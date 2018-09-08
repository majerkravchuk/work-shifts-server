# Craete DMS/Envision business, facilities and positions
%w[business facility position worker profile production_admin development_admin shift email_template].each do |file|
  require "#{Rails.root}/db/seeds/#{file}"
end

Seeds::Business.new.seed!
Seeds::Facility.new.seed!
Seeds::Position.new.seed!

if Rails.env.production?
  Seeds::ProductionAdmin.new.seed!
else
  Seeds::DevelopmentAdmin.new.seed!
  Seeds::Worker.new.seed!
  Seeds::Profile.new.seed!
end

Seeds::Shift.new.seed!
Seeds::EmailTemplate.new.seed!

Audited::Audit.delete_all
