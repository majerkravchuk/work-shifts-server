class CreateInvitationLoadingResults < ActiveRecord::Migration[5.2]
  def change
    create_table :invitation_loading_results do |t|
      t.belongs_to :business
      t.belongs_to :manager
      t.integer :status

      t.timestamps
    end
  end
end
