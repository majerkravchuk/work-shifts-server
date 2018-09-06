ActiveAdmin.register Position, as: 'EmployeePosition' do
  menu parent: 'Positions', priority: 2

  permit_params :name, :business_id, :role, manager_position_ids: []

  config.sort_order = 'name_asc'

  controller do
    def scoped_collection
      end_of_association_chain.employees
    end

    def create
      params[:position][:business_id] = current_business.id
      params[:position][:role] = :employee
      super
    end
  end

  index do
    column :name
    column(:manager_positions) { |position| position.manager_positions.pluck(:name).join(', ') }
    actions
  end

  filter :name
  filter :manager_positions,
         as: :select,
         collection: proc { current_business.manager_positions }

  show do
    attributes_table do
      row :name
      row(:manager_positions) { |positions| positions.manager_positions.pluck(:name).join(', ') }
      row :created_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      collected_data = current_business.manager_positions.map do |position|
        [
          position.name,
          position.id,
          {
            checked: f.object.manager_positions.include?(position)
          }
        ]
      end
      f.input :manager_positions, as: :check_boxes, collection: collected_data
    end
    f.actions
  end
end
