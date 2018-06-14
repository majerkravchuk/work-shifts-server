class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.belongs_to :business
      t.belongs_to :position
      t.belongs_to :manager
      t.string :name
      t.string :email, index: true
      t.string :token
      t.integer :role, null: false
      t.integer :status, default: 0

      t.timestamps
    end

    create_table :facilities_invitation, id: false do |t|
      t.belongs_to :facility
      t.belongs_to :invitation
    end
  end
end
