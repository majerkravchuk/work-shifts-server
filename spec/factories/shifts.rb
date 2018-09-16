# == Schema Information
#
# Table name: shifts
#
#  id          :bigint(8)        not null, primary key
#  end_time    :string
#  name        :string
#  start_time  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  facility_id :bigint(8)
#  position_id :bigint(8)
#
# Indexes
#
#  index_shifts_on_business_id  (business_id)
#  index_shifts_on_facility_id  (facility_id)
#  index_shifts_on_position_id  (position_id)
#

FactoryBot.define do
  factory :shift do
    sequence(:name) { |n| "Shift #{n}" }
    association :business, factory: :business
    association :facility, factory: :facility
    association :position, factory: :position_employee
    start_time { '00:00 am' }
    end_time { '01:00 am' }
  end
end
