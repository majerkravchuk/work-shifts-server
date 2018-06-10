# == Schema Information
#
# Table name: assignments
#
#  id          :bigint(8)        not null, primary key
#  date        :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  employee_id :bigint(8)
#  facility_id :bigint(8)
#  shift_id    :bigint(8)
#
# Indexes
#
#  index_assignments_on_business_id  (business_id)
#  index_assignments_on_employee_id  (employee_id)
#  index_assignments_on_facility_id  (facility_id)
#  index_assignments_on_shift_id     (shift_id)
#

class Assignment < ApplicationRecord
  # === relations ===
  belongs_to :business
  belongs_to :facility
  belongs_to :employee
  belongs_to :shift

  # === instance methods ===
  def start_time
    Time.parse("#{date} #{shift.start_time}")
  end

  def end_time
    end_date = shift.start_time < shift.end_time ? date : date + 1.day
    Time.parse("#{end_date} #{shift.end_time}")
  end
end
