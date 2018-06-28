class CreateEmailLoaderRows < ActiveRecord::Migration[5.2]
  def change
    create_table :email_loader_rows do |t|
      t.belongs_to :business
      t.belongs_to :result
      t.integer :status
      t.integer :row
      t.string :message

      t.timestamps
    end
  end
end
