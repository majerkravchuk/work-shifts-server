# == Schema Information
#
# Table name: positions
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#

class Position < ApplicationRecord
  # === relations ===
  belongs_to :business
  has_many :users
  has_many :manager_position_accesses
  has_many :managers, through: :manager_position_accesses, source: :manager
  has_many :employee_position_accesses
  has_many :employees, through: :employee_position_accesses, source: :employee
end
