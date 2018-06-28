class CreateEmailLoaderResults < ActiveRecord::Migration[5.2]
  def change
    create_table :email_loader_results do |t|
      t.belongs_to :business
      t.belongs_to :manager
      t.integer :status

      t.timestamps
    end
  end
end
