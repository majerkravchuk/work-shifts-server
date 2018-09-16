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
  factory :position_manager, class: 'Position::Manager' do
    sequence(:name) { |n| "Position Manager #{n}" }
    association :business, factory: :business
  end
end
