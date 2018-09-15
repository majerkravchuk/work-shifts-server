# == Schema Information
#
# Table name: businesses
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  time_zone  :string           default("Pacific Time (US & Canada)")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Business < ApplicationRecord
  # === audited ===
  audited

  # === relations ===
  has_many :positions
  has_many :employee_positions, class_name: 'Position::Employee'
  has_many :manager_positions, class_name: 'Position::Manager'
  has_many :workers, class_name: 'User::Worker'
  has_many :employees, through: :employee_positions, source: :employees
  has_many :managers, through: :manager_positions, source: :managers
  has_many :facilities
  has_many :shifts
  has_many :email_loader_results, class_name: 'EmailLoader::Result'
  has_many :audits, class_name: 'BusinessAudit'

  # === validations ===
  validates_presence_of :name, :time_zone
end
