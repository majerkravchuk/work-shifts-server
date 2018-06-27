SuperAdmin.create!(
  name: Faker::Name.name,
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: :super_admin,
)

businesses = [
  { name: 'DMS/Envision', subdomain: 'dms'},
  { name: 'Fake business', subdomain: 'fake'}
]

facility_names = [
  'Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley',
  'Henderson', 'Common'
]

businesses = businesses.map do |business_data|
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

  positions = manager_positions.cycle

  5.times do |i|
    Manager.create!(
      name: Faker::Name.name,
      email: "manager#{i + 1}@example.com",
      password: 'password',
      password_confirmation: 'password',
      role: :manager,
      business: business,
      position: positions.next,
    )
  end

  positions = employee_positions.cycle

  5.times do
    employee = Employee.create!(
      name: Faker::Name.name,
      email: Faker::Internet.safe_email,
      password: 'password',
      password_confirmation: 'password',
      role: :employee,
      business: business,
      position: positions.next,
    )

    employee.allowed_facilities << facilities.sample
  end

  business
end

shifts_data = YAML.load_file("#{Rails.root}/db/import/shifts.yml")

businesses.each do |business|
  shifts_data.each do |data|
    position = business.employee_positions.find_by_name(data['position_name'])

    data['facilities'].each do |facility_data|
      facility = business.facilities.find_by_name(facility_data['name'])

      facility_data['shifts'].each do |shift_data|
        Shift.create(
          business: business,
          facility: facility,
          employee_position: position,
          name: shift_data['name'],
          start_time: shift_data['start_time'],
          end_time: shift_data['end_time']
        )
      end
    end
  end
end
