class CreateFacilitiesProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :facilities_profiles, id: false do |t|
      t.belongs_to :business
      t.belongs_to :profile
      t.belongs_to :facility
    end
  end
end
