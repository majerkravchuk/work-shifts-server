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

class User < ApplicationRecord
  # === audited ===
  audited

  # === devise settings ===
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  # === relations ===
  belongs_to :business, required: false
  belongs_to :position, required: false
  # has_many :invitation_loading_results, class_name: 'InvitationLoading::Result'

  # === validations ===
  validates_presence_of   :email, :name
  validates_uniqueness_of :email, case_sensitive: true, scope: :business_id
  validates_format_of     :email, with: /\A[^@\s]+@[^@\s]+\z/

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, minimum: 8, maximum: 32, allow_blank: true

  # === enums ===
  enum role: %i[employee manager administrator]
  enum invitation_status: %i[uploaded invited accepted]

  # === class methods ===
  class << self
    def from_uploader_row(business, row, fields)
      user = business.send(fields[:role].to_s.pluralize).find_or_initialize_by(email: fields[:email])
      user.invitation_status = :uploaded if user.invitation_status.nil?
      user.name = fields[:name]
      user.role = fields[:role]
      user.position = business.positions.where('LOWER(name) = ?', fields[:position].downcase).first

      if fields[:role] == :employee
        facilities = business.facilities.where('LOWER(name) IN (?)', fields[:facilities].map(&:downcase))
        user.facilities = facilities
      end

      if user.new_record?
        row.status = :created
        row.message = "User with email [#{fields[:email]}] successfully uploaded!"
      else
        row.status = :updated
        row.message = "User with email [#{fields[:email]}] successfully updated!"
      end

      row.save
      user.save
      user
    end

  #   def find_for_authentication(warden_conditions)
  #     allowed_roles = [:manager]
  #     allowed_roles.push(:employee) unless warden_conditions[:path].split('/')[1].eql?('admin')
  #
  #     where(
  #       email: warden_conditions[:email],
  #       role: :administrator
  #     ).or(
  #       where(
  #         email: warden_conditions[:email],
  #         role: allowed_roles,
  #         business: Business.find_by_subdomain(warden_conditions[:subdomain])
  #       )
  #     ).first
  #   end
  end

  #=== instance methods ===
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
