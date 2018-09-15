# == Schema Information
#
# Table name: positions
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#
# Indexes
#
#  index_positions_on_business_id  (business_id)
#

FactoryBot.define do
  factory :position do
    sequence(:name) { |n| "Position #{n}" }
    association :business, factory: :business

    trait :manager do
      sequence(:name) { |n| "Manager Position #{n}" }
      type { 'Position::Manager' }
    end

    trait :employee do
      sequence(:name) { |n| "Employee Position #{n}" }
      type { 'Position::Employee' }
    end
  end
end
