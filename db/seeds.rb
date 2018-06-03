# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# if Rails.env.development?
  business = Business.create(name: 'DMS/Envision', subdomain: 'dms')
  fake = Business.create(name: 'Fake business', subdomain: 'fake')

  facilities = ['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson']
  facilities.each { |name| Facility.create(name: name, business: business) }

  positions = %w[Physician APP]
  positions = positions.map { |name| Position.create(name: name, business: business) }

  Position.create(name: 'Fake', business: fake)

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
    business: business,
    position: positions.first
  )

  User.create!(
    email: 'user_1@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :user,
    business: business,
    position: positions.first
  )

  User.create!(
    email: 'user_2@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: :user,
    business: business,
    position: positions.second
  )
# end
