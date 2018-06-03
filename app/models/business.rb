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
end
