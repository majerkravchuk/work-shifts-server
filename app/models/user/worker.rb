# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  invitation_status      :integer
#  invitation_token       :string
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
#  business_id            :bigint(8)
#  inviter_id             :integer
#  position_id            :bigint(8)
#
# Indexes
#
#  index_users_on_business_id           (business_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_position_id           (position_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User
  class Worker < User
    # === relations ===
    belongs_to :position
    belongs_to :manager_position, class_name: 'Position::Manager', foreign_key: :position_id, optional: true
    has_many :employee_positions, through: :manager_position
    has_and_belongs_to_many :facilities, join_table: :employees_facilities, foreign_key: :employee_id
  end
end
