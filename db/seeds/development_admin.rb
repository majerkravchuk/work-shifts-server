require "#{Rails.root}/db/seeds/base"

module Seeds
  class DevelopmentAdmin < Base
    def seed!
      admin = User::Admin.create!(
        name: 'Admin',
        email: 'admin@example.com',
        password: '123123123',
        password_confirmation: '123123123',
      )
      log(admin)

      super_admin = User::SuperAdmin.create!(
        name: 'Super Admin',
        email: 'super_admin@example.com',
        password: '123123123',
        password_confirmation: '123123123',
       )
      log(super_admin)
    end
  end
end
