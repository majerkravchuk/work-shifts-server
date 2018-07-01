class CreateEmailTemplateBases < ActiveRecord::Migration[5.2]
  def change
    create_table :email_template_bases do |t|
      t.integer :business_id
      t.string :type

      t.string :name
      t.string :key
      t.string :body

      t.integer :status, default: 0

      t.timestamps
    end
  end
end
