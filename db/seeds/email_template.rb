# default_email_templates_data = YAML.load_file("#{Rails.root}/db/import/default_email_templates.yml")
# default_email_templates_data.each do |data|
#   EmailTemplate.create(
#     name: data['name'],
#     key: data['key'],
#     body: data['body']
#   )
# end

require "#{Rails.root}/db/seeds/base"

module Seeds
  class EmailTemplate < Base
    def seed!
      default_email_templates_data = YAML.load_file("#{Rails.root}/db/import/default_email_templates.yml")
      default_email_templates_data.each do |data|
        email_template = ::EmailTemplate.create(
          name: data['name'],
          key: data['key'],
          body: data['body']
        )
        log(email_template)
      end
    end
  end
end
