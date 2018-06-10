# == Schema Information
#
# Table name: businesses
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  subdomain  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Business < ApplicationRecord
  # === relations ===
  has_many :users
  has_many :facilities
  has_many :positions
  has_many :manager_positions
  has_many :employee_positions
  has_many :shifts
end
