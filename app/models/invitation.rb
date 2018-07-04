# == Schema Information
#
# Table name: invitations
#
#  id               :bigint(8)        not null, primary key
#  status           :integer          default("pending")
#  token            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  allowed_email_id :bigint(8)
#  business_id      :bigint(8)
#  manager_id       :bigint(8)
#
# Indexes
#
#  index_invitations_on_allowed_email_id  (allowed_email_id)
#  index_invitations_on_business_id       (business_id)
#  index_invitations_on_manager_id        (manager_id)
#

class Invitation < ApplicationRecord
  # === relations ===
  belongs_to :business
  belongs_to :allowed_email
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id

  # === validations ===
  validates_presence_of :allowed_email, :token

  validate do
    if manager? && !position.is_a?(ManagerPosition)
      errors.add(:position, 'manager can have a position only for managers')
    end

    if employee? && !position.is_a?(EmployeePosition)
      errors.add(:position, 'emlpoyee can have a position only for employees')
    end
  end

  # === callbacks ===
  before_validation :set_token, on: [:create]
  after_create :send_email

  # === enums ===
  enum role: %i[employee manager]
  enum status: %i[pending received]

  # === delegates ===
  delegate :name, :email, :position, :role, :facilities,
           to: :allowed_email,
           allow_nil: true

  # === instance methods ===
  def set_token
    self.token = SecureRandom.urlsafe_base64(64, false)
    set_token if Invitation.exists?(token: token)
  end

  def send_email
    InvitationMailer.invitation(self).deliver_now
  end
end
