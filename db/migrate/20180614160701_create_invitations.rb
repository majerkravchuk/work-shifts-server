class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.belongs_to :business
      t.belongs_to :manager
      t.belongs_to :allowed_email
      t.string :token
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
