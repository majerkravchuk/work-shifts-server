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
  class Manager < Position
    # === relations ===
    has_many :managers, class_name: 'User::Worker', foreign_key: :position_id
    has_and_belongs_to_many :employee_positions,
                            class_name: 'Position::Employee',
                            foreign_key: :manager_position_id,
                            association_foreign_key: :employee_position_id,
                            join_table: :employee_positions_manager_positions
  end
end
