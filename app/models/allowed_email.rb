# == Schema Information
#
# Table name: allowed_emails
#
#  id          :bigint(8)        not null, primary key
#  email       :string
#  name        :string
#  role        :integer          not null
#  status      :integer          default("imported")
#  token       :string
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

class AllowedEmail < ApplicationRecord
  # === relations ===
  belongs_to :business
  belongs_to :position
  has_one :invitation
  has_and_belongs_to_many :allowed_facilities,
                          class_name: 'Facility',
                          join_table: :allowed_emails_facilities

  # === validations ===
  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/

  validate do
    if manager? && !position.kind_of?(ManagerPosition)
      errors.add(:position, 'manager can have a position only for managers')
    end

    if employee? && !position.kind_of?(EmployeePosition)
      errors.add(:position, 'emlpoyee can have a position only for employees')
    end
  end

  # === enums ===
  enum role: %i[employee manager]
  enum status: %i[imported invited]
end
