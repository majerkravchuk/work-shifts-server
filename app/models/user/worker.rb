# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  business_id            :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User
  class Worker < User
    # === relations ===
    # has_many :profiles
    # has_many :profiles
    # has_many :manager_positions, through: :position
    # has_and_belongs_to_many :facilities,
    #                         class_name: 'Facility',
    #                         foreign_key: :employee_id,
    #                         join_table: :employees_facilities

    # === validations ===
    validate do
      # if position.is_a? ManagerPosition
      # errors.add(:position, 'the manager can have a position only for the manager')
      # end
    end

  #   %i[manager employee].each do |role|
  #     define_method "#{role}?" do
  #       profile = profiles.find_by_business(business)
  #       profile.present? ? profile.manager? : false
  #     end
  #   end
  #
  #   def role(business)
  #     profile = profiles.find_by_business(business)
  #     profile.class_name
  #   end
  #   def manager?(business)
  #     profile = profiles.find_by_business(business)
  #     profile.present? ? profile.manager? : false
  #   end
  # end
  end
end
