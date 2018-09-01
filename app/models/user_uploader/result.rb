# == Schema Information
#
# Table name: user_uploader_results
#
#  id          :bigint(8)        not null, primary key
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  user_id     :bigint(8)
#
# Indexes
#
#  index_user_uploader_results_on_business_id  (business_id)
#  index_user_uploader_results_on_user_id      (user_id)
#

module UserUploader
  class Result < ApplicationRecord
    # === audited ===
    audited

    # === consts ===
    SAVE_LAST_RECORDS_COUNT = 8

    # === relations ===
    belongs_to :business
    belongs_to :user
    has_many :rows, dependent: :delete_all

    has_one_attached :file

    # === callbacks ===
    before_create :destroy_old_results

    # === enums ===
    enum status: %i[uploaded uploaded_with_errors rejected]

    #=== instance methods ===
    def destroy_old_results
      ids = UserUploader::Result.order(created_at: :desc).first(SAVE_LAST_RECORDS_COUNT - 1).map(&:id)
      UserUploader::Result.where.not(id: ids).destroy_all
    end

    def filename
      file.present? && file.attachment.present? ? file.attachment.blob.filename : 'File is missing'
    end
  end
end
