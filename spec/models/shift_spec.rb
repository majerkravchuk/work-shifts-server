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

RSpec.describe Shift, type: :model do
  context 'Attributes' do
    it { expect(FactoryBot.build(:shift)).to be_valid }
    it { expect(FactoryBot.build(:shift, name: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:shift, business: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:shift, facility: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:shift, position: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:shift, start_time: nil)).to_not be_valid }
    it { expect(FactoryBot.build(:shift, end_time: nil)).to_not be_valid }
  end

  context 'Callbacks' do
    context '#normalize_time' do
      context 'start_time' do
        it { expect(FactoryBot.build(:shift, start_time: '00:00')).to be_valid }
        it { expect(FactoryBot.build(:shift, start_time: '00:00 am')).to be_valid }
        it { expect(FactoryBot.build(:shift, start_time: 'invalid time')).to_not be_valid }
      end

      context 'end_time' do
        it { expect(FactoryBot.build(:shift, end_time: '00:00')).to be_valid }
        it { expect(FactoryBot.build(:shift, end_time: '00:00 am')).to be_valid }
        it { expect(FactoryBot.build(:shift, end_time: 'invalid time')).to_not be_valid }
      end
    end
  end
end
