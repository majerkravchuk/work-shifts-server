class CreateEmployeesFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :employees_facilities, id: false do |t|
      t.belongs_to :business
      t.belongs_to :facility
      t.belongs_to :employee
    end
  end
end
