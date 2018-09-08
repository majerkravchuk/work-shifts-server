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

class User < ApplicationRecord
  # === includes ===
  include Uploadable

  # === audited ===
  audited

  # === devise settings ===
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # === relations ===
  belongs_to :business, required: false
  belongs_to :position, required: false
  has_many :profiles, foreign_key: :user_id

  # === validations ===
  validates_presence_of   :email, :name
  validates_uniqueness_of :email, case_sensitive: true, scope: :business_id
  validates_format_of     :email, with: /\A[^@\s]+@[^@\s]+\z/

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, minimum: 8, maximum: 32, allow_blank: true

  validate do
    # if admin? && position.present?
    #   errors.add(:position, 'the admin can not have a position')
    #
    # elsif manager? && !position.manager?
    #   errors.add(:position, 'the manager can have a position only for the manager')
    #
    # elsif employee? && !position.employee?
    #   errors.add(:position, 'the employee can have a position only for the employee')
    # end
  end

  # === enums ===
  enum invitation_status: %i[uploaded invited accepted]

  # === scopes ===
  scope :not_in_inviting_process, -> { where(invitation_status: [:accepted, nil]) }

  # === class methods ===
  class << self
  # def find_for_authentication(warden_conditions)
  #   allowed_roles = [:manager]
  #   allowed_roles.push(:employee) unless warden_conditions[:path].split('/')[1].eql?('admin')
  #
  #   where(
  #     email: warden_conditions[:email],
  #     role: :administrator
  #   ).or(
  #     where(
  #       email: warden_conditions[:email],
  #       role: allowed_roles,
  #       business: Business.find_by_subdomain(warden_conditions[:subdomain])
  #     )
  #   ).first
  # end
  end

  # === instance methods ===
  %i[employee manager admin super_admin].each do |role|
    define_method("#{role}?") do |business = nil|
      if %i[admin super_admin].include?(role)
        type == "User::#{role.to_s.camelize}"
      else
        profile = profiles.find_by(business: business)
        return false if profile.nil?
        profile.position.type == "Position::#{role.to_s.camelize}"
      end
    end
  end

  def invite!
    invited!
  end

  def set_invitation_token!
    self.invitation_token = SecureRandom.urlsafe_base64(64, false)
    set_invitation_token! if User.exists?(invitation_token: invitation_token)
  end

  protected

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
