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

RSpec.describe Facility, type: :model do
  context 'Attributes' do
    it { expect(FactoryBot.build(:facility)).to be_valid }
    it { expect(FactoryBot.build(:facility, name: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:facility, business: nil)).to_not be_valid }
  end
end
