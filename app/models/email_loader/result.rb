# == Schema Information
#
# Table name: email_loader_results
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
#  index_email_loader_results_on_business_id  (business_id)
#  index_email_loader_results_on_manager_id   (manager_id)
#

class EmailLoader::Result < ApplicationRecord
  # === relations ===
  belongs_to :business
  belongs_to :manager, class_name: 'User', foreign_key: :manager_id
  has_many :rows, dependent: :delete_all

  has_one_attached :file

  # === callbacks ===
  # before_create :destroy_old_results

  # === enums ===
  enum status: %i[uploaded rejected]

  #=== instance methods ===
  def destroy_old_results
    EmailLoader::Result.where('created_at < ?', 10.days.ago).destroy_all
  end

  def filename
    if file.present? && file.attachment.present?
      file.attachment.blob.filename
    else
      'File is missing'
    end
  end
end
