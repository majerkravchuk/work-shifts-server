ActiveAdmin.register ManagerPosition do
  menu parent: 'Positions', priority: 1

  permit_params :name, :business_id, employee_position_ids: []

  config.sort_order = 'name_asc'

  controller do
    def create
      params[:manager_position][:business_id] = current_business.id
      super
    end
  end

  index do
    column :name
    column(:employee_positions) do |manager_position|
      manager_position.employee_positions.pluck(:name).sort.join(', ')
    end
    actions
  end

  filter :name
  filter :employee_positions,
         as: :select,
         collection: proc { current_business.employee_positions }

  show do
    attributes_table do
      row :name
      row(:employee_positions) do |manager_position|
        manager_position.employee_positions.pluck(:name).join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      collected_data = current_business.employee_positions.map do |position|
        [
          position.name,
          position.id,
          {
            checked: f.object.employee_positions.include?(position)
          }
        ]
      end
      f.input :employee_positions, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
