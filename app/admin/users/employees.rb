ActiveAdmin.register Employee do
  menu parent: 'Users', priority: 3

  includes :position, :facilities

  permit_params :name, :email, :business_id, :position_id, :password, :password_confirmation, facility_ids: []

  config.sort_order = 'name_asc'

  controller do
    def create
      params[:employee][:business_id] = current_business.id
      super
    end

    def update
      if params[:employee][:password].blank? && params[:employee][:password_confirmation].blank?
        params[:employee].delete('password')
        params[:employee].delete('password_confirmation')
      end
      super
    end
  end

  member_action :reset_password, method: :post do
    resource.send_reset_password_instructions
    redirect_to admin_employees_path, notice: 'The instruction for password recovery was successfully sent.'
  end

  filter :name
  filter :email
  filter :position,
         as: :select,
         collection: proc { current_business.employee_positions }
  filter :facilities,
         as: :select,
         collection: proc { current_business.facilities }
  filter :created_at

  index do
    column :name
    column :email
    column(:position) { |user| user.position.name.capitalize }
    column(:facilities) do |employee|
      employee.facilities.pluck(:name).sort.join(', ')
    end
    column :created_at
    actions defaults: true do |manager|
      link_to 'Reset password', reset_password_admin_employee_path(manager), method: :post
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row(:position) { |employee| employee.position.name.capitalize }
      row(:facilities) { |employee| employee.facilities.pluck(:name).sort.join(', ') }
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
        collection: current_user.employee_positions.map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
      collected_data = current_business.facilities.map do |facility|
        [
          facility.name,
          facility.id,
          { checked: f.object.facilities.include?(facility) }
        ]
      end
      f.input :facilities, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
