require "#{Rails.root}/db/seeds/base"

module Seeds
  class ProductionAdmin < Base
    def seed!
      admin = User::Admin.create!(
        name: 'Admin',
        email: Rails.application.credentials.users[:administrator][:email],
        password: Rails.application.credentials.users[:administrator][:password],
        password_confirmation: Rails.application.credentials.users[:administrator][:password],
      )
      log(admin)

      super_admin = User::SuperAdmin.create!(
        name: 'Super Admin',
        email: Rails.application.credentials.users[:super_administrator][:email],
        password: Rails.application.credentials.users[:super_administrator][:password],
        password_confirmation: Rails.application.credentials.users[:super_administrator][:password],
      )
      log(super_admin)
    end
  end
end
