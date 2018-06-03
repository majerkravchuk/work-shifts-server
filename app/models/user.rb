# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  admin                  :boolean          default(FALSE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("user")
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  business_id            :integer
#  position_id            :integer
#
# Indexes
#
#  index_users_on_email_and_business_id  (email,business_id) UNIQUE
#  index_users_on_reset_password_token   (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # === devise settings ===
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable,
         request_keys: [:subdomain]

  # === relations ===
  belongs_to :business, required: false
  belongs_to :position, required: false

  # === enums ===
  enum role: %i[user manager admin]

  # === class methods ===
  class << self
    def find_for_authentication(warden_conditions)
      where(
        email: warden_conditions[:email],
        role: :admin
      ).or(
        where(
          email: warden_conditions[:email],
          role: :manager,
          business: Business.find_by_subdomain(warden_conditions[:subdomain])
        )
      ).first
    end
  end
end
