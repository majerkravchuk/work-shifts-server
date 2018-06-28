class CreateAllowedEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :allowed_emails do |t|
      t.belongs_to :business
      t.belongs_to :position
      t.string :name
      t.string :email, index: true
      t.integer :role, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    create_table :allowed_emails_facilities, id: false do |t|
      t.belongs_to :facility
      t.belongs_to :allowed_email
    end
  end
end
