# == Schema Information
#
# Table name: email_templates
#
#  id         :bigint(8)        not null, primary key
#  body       :string
#  key        :string
#  name       :string
#  status     :integer          default("default")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EmailTemplate < ApplicationRecord
  # === audited ===
  audited

  # === enums ===
  enum status: %i[default edited]

  # === class methods ===
  class << self
    def sync_templates
      default_email_templates = load_templates
      keys = default_email_templates.map { |t| t['key'] }

      rejected_keys = EmailTemplate.where(key: keys).map(&:key)
      default_email_templates.reject! { |t| rejected_keys.include? t['key'] }

      default_email_templates.each do |template|
        EmailTemplate.create(
          name: template['name'],
          key: template['key'],
          body: template['body']
        )
      end
    end

    def email_template_for(key)
      template = find_by(key: key)

      return template if template.present?

      default_email_templates = load_templates
      default_template = default_email_templates.find { |t| t['key'] == key }

      if default_template.present?
        template = create(
          name: default_template['name'],
          key: default_template['key'],
          body: default_template['body']
        )
      end

      template
    end

    def load_templates
      YAML.load_file("#{Rails.root}/db/import/default_email_templates.yml")
    end
  end

  # === instance methods ===
  def restore_template!
    default_email_templates = self.class.load_templates
    default_template = default_email_templates.find { |t| t['key'] == key }
    update(body: default_template['body'], status: :default)
  end
end
