class CreateEmployeePositionsManagerPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_positions_manager_positions, id: false do |t|
      t.integer :manager_position_id
      t.integer :employee_position_id
    end
  end
end
