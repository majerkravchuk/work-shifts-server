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
  has_many :shifts
  has_many :managers, -> { where role: :manager }, foreign_key: :position_id
  has_many :employees, -> { where role: :employee }, foreign_key: :position_id
  has_and_belongs_to_many :manager_positions,
                          -> { where role: :manager },
                          class_name: 'Position',
                          foreign_key: :employee_position_id,
                          association_foreign_key: :manager_position_id,
                          join_table: :employee_positions_manager_positions
  has_and_belongs_to_many :employee_positions,
                          -> { where role: :employee },
                          class_name: 'Position',
                          foreign_key: :manager_position_id,
                          association_foreign_key: :employee_position_id,
                          join_table: :employee_positions_manager_positions

  # === validations ===
  # validates_presence_of :name, :role

  # # === enums ===
  # enum role: %i[employee manager]

  # === scopes ===
  # roles.keys.each { |role| scope role.pluralize.to_sym, -> { where(role: role) } }
end
