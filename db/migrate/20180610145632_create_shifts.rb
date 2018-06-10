class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.string :name
      t.belongs_to :business
      t.belongs_to :facility
      t.belongs_to :employee_position
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
