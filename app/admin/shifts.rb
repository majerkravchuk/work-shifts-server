ActiveAdmin.register Shift do
  menu priority: 5

  permit_params :name, :business_id, :facility_id, :employee_position_id, :start_time, :end_time

  config.sort_order = 'name_asc'
  config.paginate = false

  includes :facility, :position

  controller do
    def create
      params[:shift][:business_id] = current_business.id
      create!{ admin_shifts_path }
    end

    def update
      update!{ admin_shifts_path }
    end
  end

  index as: :grouped_by_belongs_to_table, association: :facility, association_title: :name do
    column :name
    column(:position) { |shift| shift.position.name }
    column :start_time
    column :end_time
    actions
  end

  filter :name
  filter :facility,
         as: :select,
         collection: proc { current_business.facilities }
  filter :position,
         as: :select,
         collection: proc { current_user.admin? ? current_business.employee_positions: current_user.employee_positions }

  show do
    attributes_table do
      row :name
      row(:facility) { |shift| shift.facility.name }
      row(:position) { |shift| shift.position.name }
      row :start_time
      row :end_time
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :facility,
              as: :select,
              collection: current_business.facilities.map { |p| [p.name.capitalize, p.id] },
              include_blank: false
      collected_data = if current_user.admin?
                         current_business.employee_positions.map { |p| [p.name.capitalize, p.id] }
                       else
                         current_user.employee_positions.map { |p| [p.name.capitalize, p.id] }
                       end
      f.input :position, as: :select, collection: collected_data, include_blank: false
      f.input :start_time, input_html: { autocomplete: :off, placeholder: '00:00 AM', class: 'time-input' }
      f.input :end_time, input_html: { autocomplete: :off, placeholder: '00:00 AM', class: 'time-input' }
    end
    f.actions
  end
end
