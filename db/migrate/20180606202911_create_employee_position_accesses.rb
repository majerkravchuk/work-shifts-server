class CreateEmployeePositionAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_position_accesses do |t|
      t.integer :business_id, null: false
      t.belongs_to :employee
      t.belongs_to :position

      t.timestamps
    end
  end
end
