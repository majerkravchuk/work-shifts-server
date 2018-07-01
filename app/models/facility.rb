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

class Facility < ApplicationRecord
  # === relations ===
  belongs_to :business
  has_and_belongs_to_many :employees,
                          class_name: 'User',
                          association_foreign_key: :employee_id,
                          join_table: :employees_facilities
  has_many :shifts
end
