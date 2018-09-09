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

class User < ApplicationRecord
  # === includes ===
  include Uploadable

  # === audited ===
  audited

  # === devise settings ===
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, request_keys: [:path]

  # === relations ===
  belongs_to :business, optional: true
  belongs_to :position, optional: true
  belongs_to :inviter, class_name: 'User', optional: true

  # === validations ===
  validates_presence_of   :email, :name
  validates_uniqueness_of :email, case_sensitive: true, scope: :business_id
  validates_format_of     :email, with: /\A[^@\s]+@[^@\s]+\z/

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, minimum: 8, maximum: 32, allow_blank: true

  # === enums ===
  enum invitation_status: %i[uploaded invited accepted]

  # === scopes ===
  scope :not_in_inviting_process, -> { where(invitation_status: [:accepted, nil]) }

  # === class methods ===
  class << self
    def find_for_authentication(warden_conditions)
      allowed_positions = ['Position::Manager']
      allowed_positions.push('Position::Employee') unless warden_conditions[:path].split('/')[1].eql?('admin')

      left_joins(:position).where(
        email: warden_conditions[:email],
        type: %w[User::Admin User::SuperAdmin]
      ).or(
        left_joins(:position).where(email: warden_conditions[:email], positions: { type: allowed_positions })
      ).first
    end
  end

  # === instance methods ===
  %i[employee manager admin super_admin].each do |role|
    define_method("#{role}?") do
      if %i[admin super_admin].include?(role)
        type == "User::#{role.to_s.camelize}"
      else
        return nil if position.nil?
        position.type == "Position::#{role.to_s.camelize}"
      end
    end
  end

  def role
    class_name = %w[User::Admin User::SuperAdmin].include?(type) ? type : position.type
    class_name.split(':').last.downcase
  end

  def admin_user_form_path
    Rails.application.routes.url_helpers.send("admin_#{persisted? ? role : role.pluralize}_path", id)
  end

  def invite!(inviter)
    set_invitation_token!
    update(inviter: inviter, invitation_status: :invited)
    UserMailer.invitation(self).deliver_now
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
