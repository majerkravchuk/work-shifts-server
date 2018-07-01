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

class EmployeePosition < Position
  # === relations ===
  belongs_to :business
  has_many :employees, foreign_key: :position_id
  has_many :shifts
  has_and_belongs_to_many :manager_positions,
                          class_name: 'ManagerPosition',
                          join_table: :managers_employee_positions
end
