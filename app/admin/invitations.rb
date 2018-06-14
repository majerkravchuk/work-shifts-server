ActiveAdmin.register Invitation do
  menu priority: 6

  permit_params :email, :business_id, :position_id, :manager_id, :role,
                allowed_facility_ids: []

  config.sort_order = 'email_asc'

  controller do
    def create
      params[:invitation][:manager_id] = current_user.id
      params[:invitation][:business_id] = current_business.id
      params[:invitation][:role] = :employee if current_user.manager?
      super
    end
  end

  index do
    column :email
    column :role
    column :status
    column :position
    column(:manager) { |invitation| invitation.manager.email }
    column(:allowed_facilities) do |invitation|
      invitation.allowed_facilities.pluck(:name).sort.join(', ')
    end
    actions
  end

  filter :email
  filter :role
  filter :position,
         as: :select,
         collection: proc { current_business.positions.order(:name) }
  filter :manager,
         as: :select,
         collection: proc { current_business.admins_and_managers.order(:email).map { |m| [m.email, m.id] } }
  filter :allowed_facilities,
         as: :select,
         collection: proc { current_business.facilities.order(:name) }

  show do
    attributes_table do
      row :email
      row :status
      row :position
      row :manager
      row(:allowed_facilities) do |invitation|
        invitation.allowed_facilities.pluck(:name).sort.join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      if f.object.new_record?
        f.input :email, input_html: { autocomplete: :off }
      else
        f.input :email, input_html: { readonly: true, disabled: true, autocomplete: :off }
      end

      if current_user.super_admin?
        f.input :role, as: :select, collection: [['Manager', :manager], ['Employee', :employee]], include_blank: false
      end

      if current_user.super_admin?
        f.input :position,
                as: :select,
                collection: current_business.positions.order(:name).map { |m| [m.name, m.id] },
                include_blank: false
      else
        f.input :position,
                as: :select,
                collection: current_user.allowed_employee.positions.order(:name).map { |m| [m.name, m.id] },
                include_blank: false
      end

      collected_data = current_business.facilities.order(:name).map do |facility|
        [
          facility.name,
          facility.id,
          {
            checked: f.object.allowed_facilities.include?(facility)
          }
        ]
      end
      f.input :allowed_facilities, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
