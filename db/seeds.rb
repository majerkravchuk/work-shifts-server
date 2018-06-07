# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: :admin
)

facility_names = ['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson']

[
  { name: 'DMS/Envision', subdomain: 'dms'},
  { name: 'Fake business', subdomain: 'fake'}
].each do |business_data|
  business = Business.create(name: business_data[:name], subdomain: business_data[:subdomain])

  facilities = facility_names.map { |name| Facility.create(name: name, business: business) }

  employee_positions = []
  manager_positions = []

  %w[Physician APP].map do |name|
    employee_position = EmployeePosition.create(name: name, business: business)
    manager_position = ManagerPosition.create(name: "#{name} manager", business: business)

    employee_positions << employee_position
    manager_positions << manager_position

    manager_position.allowed_employee_positions << employee_positions
  end

  manager_positions = ['Physician manager', 'APP manager'].map do |name|
    ManagerPosition.create(name: name, business: business)
  end

  positions = employee_positions.cycle

  5.times do |i|
    employee = User.create!(
      email: "employee#{i + 1}@example.com",
      password: 'password',
      password_confirmation: 'password',
      role: :employee,
      business: business,
      position: positions.next
    )

    employee.allowed_facilities << facilities.sample
  end

  positions = manager_positions.cycle

  5.times do |i|
    User.create!(
      email: "manager#{i + 1}@example.com",
      password: 'password',
      password_confirmation: 'password',
      role: :manager,
      business: business,
      position: positions.next
    )
  end
end
