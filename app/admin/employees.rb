ActiveAdmin.register Employee do
  menu priority: 3, parent: 'Users', if: -> { current_user.super_admin? }

  includes :position

  permit_params :email, :position_id, :password, :password_confirmation,
                allowed_facility_ids: []

  config.sort_order = 'id_asc'

  controller do
    def update
      if params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?
        params[:employee].delete('password')
        params[:employee].delete('password_confirmation')
      end
      super
    end
  end

  filter :email
  filter :position,
         as: :select,
         collection: proc { EmployeePosition.where(business: current_business) }
  filter :created_at

  index do
    column :email
    column(:position) { |user| user.position.name.capitalize }
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :email
      row(:position) { |user| user.position.name.capitalize }
      row(:allowed_facilities) do |employee|
        employee.allowed_facilities.pluck(:name).join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input(:position, {
        as: :select,
        collection: EmployeePosition.where(business: current_business).map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
      collected_data = Facility.where(business: current_business).map do |facility|
        [
          facility.name,
          facility.id,
          {
            checked: f.object.allowed_facilities.include?(facility)
          }
        ]
      end
      f.input :allowed_facilities, as: :check_boxes, collection: collected_data
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
    end
    f.actions
  end
end
