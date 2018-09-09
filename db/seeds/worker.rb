require "#{Rails.root}/db/seeds/base"

module Seeds
  class Worker < Base
    def seed!
      ::Business.all.each do |business|
        positions = business.positions.all.to_a
        10.times do |i|
          user = ::User::Worker.create(
            email: "user-#{i + 1}-b-#{business.id}@example.com",
            name: "User #{i + 1} for business #{business.id}",
            password: '123123123',
            password_confirmation: '123123123',
            business: business,
            position: positions.sample
          )
          log(user)
        end
      end
    end
  end
end
