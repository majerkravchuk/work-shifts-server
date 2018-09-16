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
  end

  context 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :time_zone }
  end

  context 'Relations' do
    context 'Definitions' do
      it { should have_many(:positions) }
      it { should have_many(:employee_positions).class_name('Position::Employee') }
      it { should have_many(:manager_positions).class_name('Position::Manager') }
      it { should have_many(:workers).class_name('User::Worker') }
      it { should have_many(:employees).through(:employee_positions).source(:employees) }
      it { should have_many(:managers).through(:manager_positions).source(:managers) }
      it { should have_many(:facilities) }
      it { should have_many(:shifts) }
      it { should have_many(:audits).class_name('BusinessAudit') }
    end

    context 'Execution' do
      before(:each) { @business = FactoryBot.create(:business) }

      context 'Positions' do
        before(:each) do
          @position = FactoryBot.create(:position, business: @business)
          @manager_position = FactoryBot.create(:position_manager, business: @business)
          @employee_position = FactoryBot.create(:position_employee, business: @business)
        end

        it { expect(@business.positions).to eq([@position, @manager_position, @employee_position]) }
        it { expect(@business.manager_positions).to eq([@manager_position]) }
        it { expect(@business.employee_positions).to eq([@employee_position]) }
      end

      context 'Shifts' do
        before(:each) { @shift = FactoryBot.create(:shift, business: @business) }

        it { expect(@business.shifts).to eq([@shift]) }
      end

      context 'FAcilities' do
        before(:each) { @facility = FactoryBot.create(:facility, business: @business) }

        it { expect(@business.facilities).to eq([@facility]) }
      end
    end
  end
end
