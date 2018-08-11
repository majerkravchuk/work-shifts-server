class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name, nil: false
      t.string :time_zone, default: 'Pacific Time (US & Canada)'

      t.timestamps
    end
  end
end
