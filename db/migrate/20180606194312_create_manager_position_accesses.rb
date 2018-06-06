class CreateManagerPositionAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :manager_position_accesses do |t|
      t.integer :business_id, null: false
      t.belongs_to :manager
      t.belongs_to :position

      t.timestamps
    end
  end
end
