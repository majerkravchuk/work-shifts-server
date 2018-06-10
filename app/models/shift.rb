# == Schema Information
#
# Table name: shifts
#
#  id                   :bigint(8)        not null, primary key
#  end_time             :string
#  name                 :string
#  start_time           :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  business_id          :bigint(8)
#  employee_position_id :bigint(8)
#  facility_id          :bigint(8)
#
# Indexes
#
#  index_shifts_on_business_id           (business_id)
#  index_shifts_on_employee_position_id  (employee_position_id)
#  index_shifts_on_facility_id           (facility_id)
#

class Shift < ApplicationRecord
  # === constants ===
  TIME_FORMAT = /\A\d{2}:\d{2}\z/

  # === relations ===
  belongs_to :business
  belongs_to :facility
  belongs_to :employee_position

  # === validations ===
  validates :start_time, format: { with: TIME_FORMAT }
  validates :end_time, format: { with: TIME_FORMAT }

  # === callbacks ===
  before_validation :normalize_time

  # === instance methods ===
  def normalize_time
    self.start_time = Time.parse(start_time).strftime("%H:%M")
    self.end_time = Time.parse(end_time).strftime("%H:%M")
  end
end
