require "#{Rails.root}/db/seeds/base"

module Seeds
  class Worker < Base
    def seed!
      20.times do |i|
        user = ::User::Worker.create(email: "user-#{i + 1}@example.com", name: "User #{i + 1}")
        log(user)
      end
    end
  end
end
