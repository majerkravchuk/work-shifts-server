class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :name
      t.string :type
      t.belongs_to :business

      t.timestamps
    end
  end
end
