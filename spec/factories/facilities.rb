# == Schema Information
#
# Table name: facilities
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#
# Indexes
#
#  index_facilities_on_business_id  (business_id)
#

FactoryBot.define do
  factory :facility do
    name { 'Test facility' }
    association :business, factory: :business
  end
end
