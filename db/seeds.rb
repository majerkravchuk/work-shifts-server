SuperAdmin.create!(
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
      email: "employee#{i + 1}@example.com",
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
        { name: 'C1', from: '6am', to: '3pm' },
        { name: 'C2', from: '11am', to: '8pm' },
        { name: 'C4', from: '3pm', to: '1am' },
        { name: 'C5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Desert Springs',
      shifts: [
        { name: 'D1', from: '6am', to: '3pm' },
        { name: 'D2', from: '11am', to: '8pm' },
        { name: 'D3', from: '1pm', to: '11pm' },
        { name: 'D5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Spring Valley',
      shifts: [
        { name: 'SV1', from: '6am', to: '3pm' },
        { name: 'SV2', from: '11am', to: '8pm' },
        { name: 'SV4', from: '1pm', to: '11pm' },
        { name: 'SV5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Summerlin',
      shifts: [
        { name: 'S1', from: '6am', to: '3pm' },
        { name: 'S2', from: '10am', to: '8pm' },
        { name: 'S4', from: '3pm', to: '1am' },
        { name: 'S5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Valley',
      shifts: [
        { name: 'V1', from: '6am', to: '3pm' },
        { name: 'V2', from: '11am', to: '8pm' },
        { name: 'V4', from: '3pm', to: '12:30am' },
        { name: 'V5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Henderson',
      shifts: [
        { name: 'H1', from: '6am', to: '4pm' },
        { name: 'H2', from: '11am', to: '9pm' },
        { name: 'H4', from: '3pm', to: '1am' },
        { name: 'H5', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'On Call',
      shifts: [
        { name: 'OC', from: '4:45am', to: '4:44am' }
      ]
    }]
  }, {
    position_name: 'Physician',
    facilities: [{
      name: 'Centennial',
      shifts: [
        { name: '1C', from: '8am', to: '5pm' },
        { name: '2C', from: '11am', to: '8pm' },
        { name: '4C', from: '4pm', to: '2am' },
        { name: '5C', from: '7pm', to: '5am' }
      ]
    }, {
      name: 'Desert Springs',
      shifts: [
        { name: '1D', from: '8am', to: '5pm' },
        { name: '2D', from: '10am', to: '8pm' },
        { name: '3D', from: '5pm', to: '2pm' },
        { name: '5D', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Spring Valley',
      shifts: [
        { name: '1SV', from: '8am', to: '6pm' },
        { name: '2SV', from: '10am', to: '8pm' },
        { name: '4SV', from: '4pm', to: '2pm' },
        { name: '5SV', from: '7pm', to: '5am' }
      ]
    }, {
      name: 'Summerlin',
      shifts: [
        { name: '1S', from: '8am', to: '6pm' },
        { name: '2S', from: '11am', to: '9pm' },
        { name: '4S', from: '4pm', to: '2am' },
        { name: '5S', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Valley',
      shifts: [
        { name: '1V', from: '7am', to: '4pm' },
        { name: '2V', from: '12am', to: '9pm' },
        { name: '4V', from: '4pm', to: '1am' },
        { name: '5V', from: '8pm', to: '6am' }
      ]
    }, {
      name: 'Henderson',
      shifts: [
        { name: '1H', from: '8am', to: '6pm' },
        { name: '2H', from: '10am', to: '8pm' },
        { name: '4H', from: '4pm', to: '2am' },
        { name: '5H', from: '7pm', to: '5am' }
      ]
    }, {
      name: 'On Call',
      shifts: [
        { name: 'OC', from: '7am', to: '6:59am' }
      ]
    }]
  }]

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
          from: shift_data[:from],
          to: shift_data[:to]
        )
      end
    end
  end
end
