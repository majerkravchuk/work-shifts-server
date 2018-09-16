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

RSpec.describe Position::Manager, type: :model do
  context 'Role' do
    it { expect(FactoryBot.build(:position_manager).manager?).to be_truthy }
    it { expect(FactoryBot.build(:position_manager).employee?).to be_falsey }
  end
end