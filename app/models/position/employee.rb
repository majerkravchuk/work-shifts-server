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

class Position
  class Employee < Position
    # === relations ===
    has_many :shifts
    has_many :employees, class_name: 'User::Worker', foreign_key: :position_id
    has_and_belongs_to_many :manager_positions,
                            class_name: 'Position::Manager',
                            foreign_key: :employee_position_id,
                            association_foreign_key: :manager_position_id,
                            join_table: :employee_positions_manager_positions
  end
end
