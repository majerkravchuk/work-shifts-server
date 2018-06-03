class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities do |t|
      t.string :name
      t.integer :business_id, null: false

      t.timestamps
    end
  end
end
