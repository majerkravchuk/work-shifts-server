# == Schema Information
#
# Table name: allowed_emails
#
#  id          :bigint(8)        not null, primary key
#  email       :string
#  name        :string
#  role        :integer          not null
#  status      :integer          default("imported")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  position_id :bigint(8)
#
# Indexes
#
#  index_allowed_emails_on_business_id  (business_id)
#  index_allowed_emails_on_email        (email)
#  index_allowed_emails_on_position_id  (position_id)
#

# class AllowedEmail < ApplicationRecord
  # # === audited ===
  # audited
  #
  # # === relations ===
  # belongs_to :business
  # belongs_to :position
  # has_one :invitation, dependent: :destroy
  # has_and_belongs_to_many :facilities
  #
  # # === validations ===
  # validates_presence_of :email
  # validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
  #
  # validate do
  #   if manager? && !position.is_a?(ManagerPosition)
  #     errors.add(:position, 'manager can have a position only for managers')
  #   end
  #
  #   if employee? && !position.is_a?(EmployeePosition)
  #     errors.add(:position, 'emlpoyee can have a position only for employees')
  #   end
  # end
  #
  # # === enums ===
  # enum role: %i[employee manager]
  # enum status: %i[imported invited]
  #
  # # === class methods ===
  # class << self
  #   def update_or_create_for_loader_row(business, row, fields)
  #     email = business.allowed_email.find_or_initialize_by(email: fields[:email])
  #     email.name = fields[:name]
  #     email.role = fields[:role]
  #     email.position = business.positions.where('LOWER(name) = ?', fields[:position].downcase).first
  #
  #     if fields[:role] == :employee
  #       facilities = business.facilities.where('LOWER(name) IN (?)', fields[:facilities].map(&:downcase))
  #       email.facilities = facilities
  #     end
  #
  #     if email.new_record?
  #       row.status = :created
  #       row.message = "Allowed email for [#{fields[:email]}] successfully imported!"
  #     else
  #       row.status = :updated
  #       row.message = "Allowed email for [#{fields[:email]}] successfully updated!"
  #     end
  #
  #     row.save
  #     email.save
  #     email
  #   end
  # end
# end
