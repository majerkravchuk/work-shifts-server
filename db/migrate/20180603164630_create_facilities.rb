class CreateFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities do |t|
      t.string :name
      t.belongs_to :business

      t.timestamps
    end
  end
end
