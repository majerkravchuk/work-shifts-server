class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :name
      t.belongs_to :business
      t.string :type

      t.timestamps
    end
  end
end
