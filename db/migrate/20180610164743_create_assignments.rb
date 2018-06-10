class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.belongs_to :business
      t.belongs_to :facility
      t.belongs_to :employee
      t.belongs_to :shift
      t.date :date

      t.timestamps
    end
  end
end
