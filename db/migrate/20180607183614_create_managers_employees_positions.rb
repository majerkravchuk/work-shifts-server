class CreateManagersEmployeesPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :managers_employee_positions, id: false do |t|
      t.belongs_to :business
      t.belongs_to :manager_position
      t.belongs_to :employee_position
    end
  end
end
