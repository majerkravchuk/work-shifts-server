Faker::Name.name      #=> "Christophe Bartell"

Faker::Internet.email #=> "kirsten.greenholt@corkeryfisher.info"


SuperAdmin.create!(
  name: Faker::Name.name,
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  role: :super_admin
)

businesses = [
  { name: 'DMS/Envision', subdomain: 'dms'},
  { name: 'Fake business', subdomain: 'fake'}
]

facility_names = ['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson', 'On Call']

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
      position: positions.next
    )
  end

  positions = employee_positions.cycle

  5.times do |i|
    employee = Employee.create!(
      name: Faker::Name.name,
      email: Faker::Internet.safe_email,
      password: 'password',
      password_confirmation: 'password',
      role: :employee,
      business: business,
      position: positions.next
    )

    employee.allowed_facilities << facilities.sample
  end

  business
end

shifts_data = [
  {
    position_name: 'Physician',
    facilities: [{
      name: 'Centennial',
      shifts: [
        { name: 'C1', start_time: '6am', end_time: '3pm' },
        { name: 'C2', start_time: '11am', end_time: '8pm' },
        { name: 'C4', start_time: '3pm', end_time: '1am' },
        { name: 'C5', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Desert Springs',
      shifts: [
        { name: 'D1', start_time: '6am', end_time: '3pm' },
        { name: 'D2', start_time: '11am', end_time: '8pm' },
        { name: 'D3', start_time: '1pm', end_time: '11pm' },
        { name: 'D5', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Spring Valley',
      shifts: [
        { name: 'SV1', start_time: '6am', end_time: '3pm' },
        { name: 'SV2', start_time: '11am', end_time: '8pm' },
        { name: 'SV4', start_time: '1pm', end_time: '11pm' },
        { name: 'SV5', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Summerlin',
      shifts: [
        { name: 'S1', start_time: '6am', end_time: '3pm' },
        { name: 'S2', start_time: '10am', end_time: '8pm' },
        { name: 'S4', start_time: '3pm', end_time: '1am' },
        { name: 'S5', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Valley',
      shifts: [
        { name: 'V1', start_time: '6am', end_time: '3pm' },
        { name: 'V2', start_time: '11am', end_time: '8pm' },
        { name: 'V4', start_time: '3pm', end_time: '12:30am' },
        { name: 'V5', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Henderson',
      shifts: [
        { name: 'H1', start_time: '6am', end_time: '4pm' },
        { name: 'H2', start_time: '11am', end_time: '9pm' },
        { name: 'H4', start_time: '3pm', end_time: '1am' },
        { name: 'H5', start_time: '8pm', end_time: '6am' }
      ]
    }]
  }, {
    position_name: 'APP',
    facilities: [{
      name: 'Centennial',
      shifts: [
        { name: '1C', start_time: '8am', end_time: '5pm' },
        { name: '2C', start_time: '11am', end_time: '8pm' },
        { name: '4C', start_time: '4pm', end_time: '2am' },
        { name: '5C', start_time: '7pm', end_time: '5am' }
      ]
    }, {
      name: 'Desert Springs',
      shifts: [
        { name: '1D', start_time: '8am', end_time: '5pm' },
        { name: '2D', start_time: '10am', end_time: '8pm' },
        { name: '3D', start_time: '5pm', end_time: '2pm' },
        { name: '5D', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Spring Valley',
      shifts: [
        { name: '1SV', start_time: '8am', end_time: '6pm' },
        { name: '2SV', start_time: '10am', end_time: '8pm' },
        { name: '4SV', start_time: '4pm', end_time: '2pm' },
        { name: '5SV', start_time: '7pm', end_time: '5am' }
      ]
    }, {
      name: 'Summerlin',
      shifts: [
        { name: '1S', start_time: '8am', end_time: '6pm' },
        { name: '2S', start_time: '11am', end_time: '9pm' },
        { name: '4S', start_time: '4pm', end_time: '2am' },
        { name: '5S', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Valley',
      shifts: [
        { name: '1V', start_time: '7am', end_time: '4pm' },
        { name: '2V', start_time: '12am', end_time: '9pm' },
        { name: '4V', start_time: '4pm', end_time: '1am' },
        { name: '5V', start_time: '8pm', end_time: '6am' }
      ]
    }, {
      name: 'Henderson',
      shifts: [
        { name: '1H', start_time: '8am', end_time: '6pm' },
        { name: '2H', start_time: '10am', end_time: '8pm' },
        { name: '4H', start_time: '4pm', end_time: '2am' },
        { name: '5H', start_time: '7pm', end_time: '5am' }
      ]
    }]
  }]

businesses.each do |business|
  business.employee_positions.each do |position|
    Shift.create(
      business: business,
      employee_position: position,
      name: 'OC',
      start_time: '7am',
      end_time: '6:59am'
    )
  end
end

businesses.each do |business|
  shifts_data.each do |data|
    position = business.employee_positions.find_by_name(data[:position_name])

    data[:facilities].each do |facility_data|
      facility = business.facilities.find_by_name(facility_data[:name])

      facility_data[:shifts].each do |shift_data|
        Shift.create(
          business: business,
          facility: facility,
          employee_position: position,
          name: shift_data[:name],
          start_time: shift_data[:start_time],
          end_time: shift_data[:end_time]
        )
      end
    end
  end
end
