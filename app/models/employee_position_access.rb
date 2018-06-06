# == Schema Information
#
# Table name: employee_position_accesses
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#  employee_id :bigint(8)
#  position_id :bigint(8)
#
# Indexes
#
#  index_employee_position_accesses_on_employee_id  (employee_id)
#  index_employee_position_accesses_on_position_id  (position_id)
#

class EmployeePositionAccess < ApplicationRecord
  # === relations ===
  belongs_to :employee, class_name: 'User'
  belongs_to :position

  # === validations ===
  validate :businesses_must_be_same
  validate :user_must_has_employee_role

  # === callbacks ===
  before_save :set_business_id

  # === instance methods ===
  def businesses_must_be_same
    if employee.business_id != position.business_id
      errors.add :similarity_of_businesses, 'can not access a position from another business'
    end
  end

  def user_must_has_employee_role
    unless employee.employee?
      errors.add :user_must_has_employee_role, 'only a employee can work on positions'
    end
  end

  def set_business_id
    self.business_id = employee.business_id
  end
end
