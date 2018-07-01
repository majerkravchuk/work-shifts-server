# == Schema Information
#
# Table name: email_template_bases
#
#  id          :bigint(8)        not null, primary key
#  body        :string
#  key         :string
#  name        :string
#  status      :integer          default("default")
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :integer
#

class EmailTemplate::Base < ApplicationRecord
  # === enums ===
  enum status: %i[default edited]
end
