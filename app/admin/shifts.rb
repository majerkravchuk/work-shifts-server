ActiveAdmin.register Shift do
  menu priority: 5

  permit_params :name, :business_id, :facility_id, :employee_position_id, :start_time, :end_time

  config.sort_order = 'name_asc'
  config.paginate = false

  includes :facility, :employee_position

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
    column(:employee_position) { |shift| shift.employee_position.name }
    column :start_time
    column :end_time
    actions
  end

  filter :name
  filter :facility
  filter :employee_position,
         as: :select,
         collection: proc { current_user.employee_positions },
         if: proc { current_user.super_admin? }

  show do
    attributes_table do
      row :name
      row(:facility) { |shift| shift.facility.name }
      row(:employee_position) { |shift| shift.employee_position.name }
      row :start_time
      row :end_time
      row :created_at
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input(:facility, {
        as: :select,
        collection: current_business.facilities.map { |p| [p.name.capitalize, p.id] }
      })
      f.input(:employee_position, {
        as: :select,
        collection: current_user.employee_positions.map { |p| [p.name.capitalize, p.id] },
        include_blank: false
      })
      f.input :start_time, input_html: { autocomplete: :off, placeholder: '00:00 AM', class: 'time-input' }
      f.input :end_time, input_html: { autocomplete: :off, placeholder: '00:00 AM', class: 'time-input' }
    end
    f.actions
  end
end
