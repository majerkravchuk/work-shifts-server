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

class Position < ApplicationRecord
  # === audited ===
  audited

  # === relations ===
  belongs_to :business

  # === validations ===
  validates_presence_of :name
end
