ActiveAdmin.register Employee do
  menu priority: 3, parent: 'Users', if: -> { current_user.super_admin? }

  includes :position, :allowed_facilities

  permit_params :name, :email, :business_id, :position_id, :password, :password_confirmation,
                allowed_facility_ids: []

  config.sort_order = 'email_asc'

  controller do
    def update
      if params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?
        params[:employee].delete('password')
        params[:employee].delete('password_confirmation')
      end
      super
    end
  end

  filter :name
  filter :email
  filter :position,
         as: :select,
         collection: proc { current_business.employee_positions }
  filter :allowed_facilities,
         as: :select,
         collection: proc { current_business.facilities }
  filter :created_at

  index do
    column :name
    column :email
    column(:position) { |user| user.position.name.capitalize }
    column(:allowed_facilities) do |employee|
      employee.allowed_facilities.pluck(:name).sort.join(', ')
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |employee| employee.position.name.capitalize }
      row(:allowed_facilities) { |employee| employee.allowed_facilities.pluck(:name).sort.join(', ') }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input(:position, {
        as: :select,
        collection: current_user.allowed_employee_positions.map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
      collected_data = current_business.facilities.map do |facility|
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
