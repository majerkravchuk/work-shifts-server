# == Schema Information
#
# Table name: positions
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#

class EmployeePosition < Position
  # === relations ===
  has_many :employees, foreign_key: :position_id
  has_and_belongs_to_many :manager_positions, join_table: :managers_employees_positions
end
