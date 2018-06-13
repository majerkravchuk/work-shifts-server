ActiveAdmin.register ManagerPosition do
  menu parent: 'Positions', priority: 1

  permit_params :name, :business_id, allowed_employee_position_ids: []

  config.sort_order = 'name_asc'

  index do
    column :name
    column(:allowed_employee_positions) do |manager_position|
      manager_position.allowed_employee_positions.pluck(:name).join(', ')
    end
    actions
  end

  filter :name
  filter :allowed_employee_positions,
         as: :select,
         collection: proc { current_business.employee_positions }

  show do
    attributes_table do
      row :name
      row(:allowed_employee_positions) do |manager_position|
        manager_position.allowed_employee_positions.pluck(:name).join(', ')
      end
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :business_id, input_html: { value: current_user.business.id }, as: :hidden
      collected_data = current_business.employee_positions.map do |position|
        [
          position.name,
          position.id,
          {
            checked: f.object.allowed_employee_positions.include?(position)
          }
        ]
      end
      f.input :allowed_employee_positions, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
