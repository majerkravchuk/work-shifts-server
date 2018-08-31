# == Schema Information
#
# Table name: user_uploader_rows
#
#  id          :bigint(8)        not null, primary key
#  message     :string
#  row         :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint(8)
#  result_id   :bigint(8)
#
# Indexes
#
#  index_user_uploader_rows_on_business_id  (business_id)
#  index_user_uploader_rows_on_result_id    (result_id)
#

module UserUploader
  class Row < ApplicationRecord
    # === relations ===
    belongs_to :business
    belongs_to :result

    # === enums ===
    enum status: %i[created updated rejected]
  end
end
