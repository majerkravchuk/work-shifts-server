# == Schema Information
#
# Table name: invitation_loading_results
#
#  id          :bigint(8)        not null, primary key
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  manager_id  :bigint(8)
#
# Indexes
#
#  index_invitation_loading_results_on_business_id  (business_id)
#  index_invitation_loading_results_on_manager_id   (manager_id)
#

class InvitationLoading::Result < ApplicationRecord
  # === relations ===
  belongs_to :business
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id
  has_many :rows, dependent: :delete_all

  # === callbacks ===
  before_create :destroy_old_results

  #=== instance methods ===
  def destroy_old_results
    InvitationLoading::Result.where('created_at < ?', 5.minutes.ago).destroy_all
  end
end
