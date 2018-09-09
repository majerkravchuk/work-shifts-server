# == Schema Information
#
# Table name: profiles
#
#  id                :bigint(8)        not null, primary key
#  invitation_status :integer
#  invitation_token  :string
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  business_id       :bigint(8)
#  inviter_id        :integer
#  position_id       :bigint(8)
#  user_id           :bigint(8)
#
# Indexes
#
#  index_profiles_on_business_id  (business_id)
#  index_profiles_on_position_id  (position_id)
#  index_profiles_on_user_id      (user_id)
#

class Profile
  class Employee < Profile
    # === relations ===
    has_and_belongs_to_many :facilities, foreign_key: :profile_id
  end
end
