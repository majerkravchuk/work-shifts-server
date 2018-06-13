ActiveAdmin.register EmployeePosition do
  menu parent: 'Positions', priority: 2

  permit_params :name, :business_id, allowed_manager_position_ids: []

  config.sort_order = 'name_asc'

  index do
    column :name
    column(:allowed_manager_positions) do |employee_position|
      employee_position.allowed_manager_positions.pluck(:name).join(', ')
    end
    actions
  end

  filter :name
  filter :allowed_manager_positions,
         as: :select,
         collection: proc { current_business.manager_positions }

  show do
    attributes_table do
      row :name
      row(:allowed_manager_positions) do |employee_position|
        employee_position.allowed_manager_positions.pluck(:name).join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
      collected_data = current_business.manager_positions.map do |position|
        [
          position.name,
          position.id,
          {
            checked: f.object.allowed_manager_positions.include?(position)
          }
        ]
      end
      f.input :allowed_manager_positions, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
