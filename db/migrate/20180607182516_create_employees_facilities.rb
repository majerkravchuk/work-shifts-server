class CreateEmployeesFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :employees_facilities, id: false do |t|
      t.belongs_to :business
      t.belongs_to :employee
      t.belongs_to :facility
    end

    create_table :employee_positions_manager_positions, id: false do |t|
      t.integer :manager_position_id
      t.integer :employee_position_id
    end
  end
end
