# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_status      :integer          default("uploaded")
#  invitation_token       :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("employee")
#  sign_in_count          :integer          default(0), not null
#  super_administrator    :boolean          default(FALSE)
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  business_id            :integer
#  inviter_id             :integer
#  position_id            :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class Manager < User
  # === relations ===
  # belongs_to :manager_position, foreign_key: :position_id
  # has_many :employee_positions, through: :manager_position

  # === validations ===
  # validate do
  #   unless position.is_a? ManagerPosition
  #     errors.add(:position, 'the manager can have a position only for the manager')
  #   end
  # end
end
