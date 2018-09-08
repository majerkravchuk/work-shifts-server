require "#{Rails.root}/db/seeds/base"

module Seeds
  class Position < Base
    def seed!
      ::Business.all.each do |business|
        %w[Physician APP].map do |name|
          manager_position = ::Position::Manager.create(name: "#{name} manager", business: business)
          log(manager_position)
          employee_position = ::Position::Employee.create(name: name, business: business)
          log(employee_position)
        end
      end
    end
  end
end
