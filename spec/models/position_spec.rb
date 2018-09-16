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

RSpec.describe Position, type: :model do
  context 'Attributes' do
    it { expect(FactoryBot.build(:position)).to be_valid }
    it { expect(FactoryBot.build(:position, name: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:position, business: nil)).to_not be_valid }
  end
end
