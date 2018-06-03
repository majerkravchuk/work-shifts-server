# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

if Rails.env.development?
  business = Business.create(name: 'DMS/Envision', subdomain: 'dms')
  Business.create(name: 'Fake business', subdomain: 'fake')

  User.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :admin,
    admin: true
  )

  User.create!(
    email: 'manager@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :manager,
    business: business
  )

  User.create!(
    email: 'user@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :user,
    business: business
  )

  facilities = ['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson']
  facilities.each { |name| Facility.create(name: name, business: business) }
end
