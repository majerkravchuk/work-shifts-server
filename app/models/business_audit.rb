# == Schema Information
#
# Table name: audits
#
#  id              :bigint(8)        not null, primary key
#  action          :string
#  associated_type :string
#  auditable_type  :string
#  audited_changes :jsonb
#  comment         :string
#  remote_address  :string
#  request_uuid    :string
#  user_type       :string
#  username        :string
#  version         :integer          default(0)
#  created_at      :datetime
#  associated_id   :integer
#  auditable_id    :integer
#  business_id     :bigint(8)
#  user_id         :integer
#
# Indexes
#
#  associated_index              (associated_type,associated_id)
#  auditable_index               (auditable_type,auditable_id)
#  index_audits_on_business_id   (business_id)
#  index_audits_on_created_at    (created_at)
#  index_audits_on_request_uuid  (request_uuid)
#  user_index                    (user_id,user_type)
#

class BusinessAudit < Audited::Audit
  # === relations ===
  belongs_to :business, required: false

  # === callbacks ===
  before_create :set_business
  before_create :set_username

  # === instance methods ===
  def set_business
    self.business = user.business if user.present?
  end

  def set_username
    self.username = user.name if user.present?
  end
end
