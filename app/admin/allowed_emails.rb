ActiveAdmin.register AllowedEmail do
  menu parent: 'Emails'

  permit_params :name, :email, :business_id, :position_id, :manager_id, :role,
                allowed_facility_ids: []

  config.sort_order = 'email_asc'
  includes :position

  action_item :import_from_file, only: :index do
    link_to 'Load from file', admin_emails_from_file_path
  end

  batch_action :invite do
    batch_action_collection.where(status: :imported).update_all(status: :invited)
    redirect_to collection_path, notice: 'The users have been invited.'
  end

  batch_action :reject_invitations do
    resource.invitation.delete
    batch_action_collection.update_all(status: :imported)
    redirect_to collection_path, notice: 'The invitations have been rejected.'
  end

  member_action :invite, method: :put do
    Invitation.create!(
      allowed_email: resource,
      business: current_business,
      manager: current_user
    )
    resource.update(status: :invited)
    redirect_to admin_allowed_emails_path, notice: 'The user has been invited.'
  end

  member_action :reject_invitation, method: :put do
    resource.invitation.delete
    resource.update(status: :imported)
    redirect_to admin_allowed_emails_path, notice: 'The invitation has been rejected.'
  end

  controller do
    def create
      params[:email][:business_id] = current_business.id
      params[:email][:role] = :employee if current_user.manager?
      super
    end
  end

  index do
    selectable_column
    column :email
    column :name
    column :role
    column :status
    column :position
    column :allowed_facilities do |invitation|
      invitation.allowed_facilities.pluck(:name).sort.join(', ')
    end
    actions defaults: true do |user|
      actions = ''

      if user.imported?
        actions += link_to 'Invite', invite_admin_allowed_email_path(user), method: :put
      end

      if user.invited?
        actions += link_to 'Reject invitation ', reject_invitation_admin_allowed_email_path(user), method: :put
      end

      actions.html_safe
    end
  end

  filter :email
  filter :name
  filter :role,
         as: :select,
         collection: proc { AllowedEmail.roles }
  filter :position,
         as: :select,
         collection: proc { current_business.positions.order(:name) }

  show do
    attributes_table do
      row :email
      row :name
      row :status
      row :position
      row(:allowed_facilities) do |invitation|
        invitation.allowed_facilities.pluck(:name).sort.join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      input_html = {}.tap do |p|
        p[:autocomplete] = :off
        p[:readonly] = !f.object.new_record?
        p[:disabled] = !f.object.new_record?
      end
      f.input :email, input_html: input_html

      f.input :name

      if current_user.super_admin?
        f.input :role,
                as: :select,
                collection: [['Employee', :employee], ['Manager', :manager]],
                include_blank: false
      end

      positions_collection = current_business.positions.order(:name).map do |position|
        if position.kind_of?(ManagerPosition) && !current_user.super_admin?
          nil
        elsif current_user.allowed_employee_positions.exclude?(position) && !current_user.super_admin?
          nil
        else
          [position.name, position.id, {
            class: position.type.underscore.gsub('_', '-'),
            hidden: position.kind_of?(ManagerPosition)
          }]
        end
      end
      f.input :position,
              as: :select,
              collection: positions_collection.compact,
              include_blank: false

      collected_data = current_business.facilities.order(:name).map do |facility|
        [facility.name, facility.id, { checked: f.object.allowed_facilities.include?(facility) }]
      end
      f.input :allowed_facilities,
              as: :check_boxes,
              collection: collected_data
    end
    f.actions
  end
end
