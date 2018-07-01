# == Schema Information
#
# Table name: businesses
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  subdomain  :string
#  time_zone  :string           default("Pacific Time (US & Canada)")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Business < ApplicationRecord
  # === relations ===
  has_many :users
  has_many :admins_and_managers, -> { where(role: %i[manager super_admin]) }, class_name: 'User'
  has_many :managers
  has_many :employees
  has_many :admins
  has_many :facilities
  has_many :positions
  has_many :manager_positions
  has_many :employee_positions
  has_many :shifts
  has_many :allowed_email
  has_many :email_loader_results, class_name: 'EmailLoader::Result'
  has_many :invitations
  has_many :email_templates, class_name: 'EmailTemplate::Template'

  # === instance methods ===
  def sync_templates
    default_templates =
      EmailTemplate::Default.where.not(key: email_templates.pluck(:key))

    default_templates.each do |template|
      email_templates.create(name: template.name, key: template.key, body: template.body)
    end
  end

  def email_template_for(key)
    template = email_templates.find_by(key: key)

    return template if template.present?

    default_template = EmailTemplate::Default.find_by(key: key)

    if default_template.present?
      template = email_templates.create(
        name: default_template.name,
        key: default_template.key,
        body: default_template.body
      )
    end

    template
  end

end
