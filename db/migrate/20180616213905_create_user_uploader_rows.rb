class CreateUserUploaderRows < ActiveRecord::Migration[5.2]
  def change
    create_table :user_uploader_rows do |t|
      t.belongs_to :business
      t.belongs_to :result
      t.integer :status
      t.integer :row
      t.string :message
    end
  end
end
