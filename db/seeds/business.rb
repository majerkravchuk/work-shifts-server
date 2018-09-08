require "#{Rails.root}/db/seeds/base"

module Seeds
  class Business < Base
    def seed!
      %w[DMS/Envision Fake].each do |name|
        business = ::Business.create name: name
        log(business)
      end
    end
  end
end
