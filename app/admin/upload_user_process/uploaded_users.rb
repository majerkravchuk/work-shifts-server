ActiveAdmin.register User::Worker, as: 'UploadedUsers' do
  menu label: 'Uploaded users', parent: 'Upload user process', priority: 2

  permit_params :name, :email, :business_id, :position_id, :manager_id, :role, facility_ids: []

  actions :index, :show

  config.sort_order = 'email_asc'
  includes :position

  action_item :import_from_file, only: :index do
    link_to 'Upload from file', admin_upload_users_path
  end

  controller do
    def scoped_collection
      end_of_association_chain.where(invitation_status: :uploaded)
    end
  end

  batch_action :invite do
    batch_action_collection.each(&:invite!)
    notice = 'The users were successfully invited. Moved to the Invitations sent page.'
    redirect_to collection_path, notice: notice
  end

  member_action :invite, method: :put do
    resource.invite!
    notice = 'The user was successfully invited. Moved to the Invitations sent page.'
    redirect_to admin_uploaded_users_path, notice: notice
  end

  index do
    selectable_column
    column :email
    column :name
    column :role
    column :invitation_status
    column :position
    column(:facilities) { |user| user.employee? ? user.facilities.pluck(:name).sort.join(', ') : '' }
    actions defaults: true do |user|
      link_to 'Invite', invite_admin_uploaded_user_path(user), method: :put
    end
  end

  filter :email
  filter :name
  filter :position,
         as: :select,
         collection: proc { current_business.positions.order(:name) }

  show do
    attributes_table do
      row :email
      row :name
      row :position
      row(:facilities) { |user| user.facilities.pluck(:name).sort.join(', ') } if resource.employee?
      row :created_at
    end
  end

  # form do |f|
  #   f.inputs do
  #     f.input :email, input_html: { autocomplete: :off }
  #
  #     f.input :name
  #
  #     if current_user.admin?
  #       f.input :role,
  #               as: :select,
  #               collection: [['Employee', :employee], ['Manager', :manager]],
  #               include_blank: false
  #     end
  #
  #     positions_collection = current_business.positions.order(:name).map do |position|
  #       if position.is_a?(ManagerPosition) && !current_user.admin?
  #         nil
  #       elsif current_user.employee_positions.exclude?(position) && !current_user.admin?
  #         nil
  #       else
  #         [position.name, position.id, {
  #           class: position.type.underscore.gsub('_', '-'),
  #           hidden: position.is_a?(ManagerPosition)
  #         }]
  #       end
  #     end
  #     f.input :position,
  #             as: :select,
  #             collection: positions_collection.compact,
  #             include_blank: false
  #
  #     collected_data = current_business.facilities.order(:name).map do |facility|
  #       [facility.name, facility.id, { checked: f.object.facilities.include?(facility) }]
  #     end
  #     f.input :facilities,
  #             as: :check_boxes,
  #             collection: collected_data
  #   end
  #   f.actions
  # end
end
