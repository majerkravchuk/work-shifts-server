require "#{Rails.root}/db/seeds/base"

module Seeds
  class Facility < Base
    def seed!
      ::Business.all.each do |business|
        ['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson', 'On Call'].map do |name|
          facility = ::Facility.create(name: name, business: business)
          log(facility)
        end
      end
    end
  end
end
