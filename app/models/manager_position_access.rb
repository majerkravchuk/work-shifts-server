# == Schema Information
#
# Table name: manager_position_accesses
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer          not null
#  manager_id  :bigint(8)
#  position_id :bigint(8)
#
# Indexes
#
#  index_manager_position_accesses_on_manager_id   (manager_id)
#  index_manager_position_accesses_on_position_id  (position_id)
#

class ManagerPositionAccess < ApplicationRecord
  # === relations ===
  belongs_to :manager, class_name: 'User'
  belongs_to :position

  # === validations ===
  validate :businesses_must_be_same
  validate :user_must_has_manager_role

  # === callbacks ===
  before_save :set_business_id

  # === instance methods ===
  def businesses_must_be_same
    if manager.business_id != position.business_id
      errors.add :similarity_of_businesses, 'can not access a position from another business'
    end
  end

  def user_must_has_manager_role
    errors.add :manager_role, 'only a manager can manage positions' unless manager.manager?
  end

  def set_business_id
    self.business_id = manager.business_id
  end
end
