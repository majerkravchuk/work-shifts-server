require "#{Rails.root}/db/seeds/base"

module Seeds
  class Profile < Base
    def seed!
      ::Business.all.each do |business|
        user_groups = ::User::Worker.all.shuffle.in_groups(2)

        user_groups.first.each do |user|
          employee_positions = business.employee_positions.all.to_a
          profile = ::Profile::Employee.create(user: user, position: employee_positions.sample, business: business)
          log(profile)
        end

        user_groups.second.each do |user|
          manager_positions = business.manager_positions.all.to_a
          profile = ::Profile::Manager.create(user: user, position: manager_positions.sample, business: business)
          log(profile)
        end
      end
    end
  end
end
