class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.belongs_to :position
      t.belongs_to :business

      t.integer :invitation_status
      t.integer :inviter_id

      t.string :invitation_token
      t.string :type

      t.timestamps
    end
  end
end
