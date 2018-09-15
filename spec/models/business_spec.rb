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

RSpec.describe Business, type: :model do
  context 'Attributes' do
    it { expect(FactoryBot.build(:business)).to be_valid }
    it { expect(FactoryBot.build(:business, name: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:business, time_zone: nil)).to_not be_valid }
  end
end
