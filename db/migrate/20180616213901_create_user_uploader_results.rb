class CreateUserUploaderResults < ActiveRecord::Migration[5.2]
  def change
    create_table :user_uploader_results do |t|
      t.belongs_to :business
      t.belongs_to :user
      t.integer :status

      t.timestamps
    end
  end
end
