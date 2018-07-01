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

class ManagerPosition < Position
  # === relations ===
  has_many :managers, foreign_key: :position_id
  has_and_belongs_to_many :employee_positions,
                          class_name: 'EmployeePosition',
                          join_table: :managers_employee_positions
end
