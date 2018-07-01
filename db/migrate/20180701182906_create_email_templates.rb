class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :key
      t.string :body

      t.integer :status, default: 0

      t.timestamps
    end
  end
end
