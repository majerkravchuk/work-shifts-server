# Craete DMS/Envision business, facilities and positions
business = Business.create(name: 'DMS/Envision')

['Centennial', 'Desert Springs', 'Spring Valley', 'Summerlin', 'Valley', 'Henderson', 'Common'].map do |name|
  Facility.create(name: name, business: business)
end

%w[Physician APP].map do |name|
  EmployeePosition.create(name: name, business: business)
  ManagerPosition.create(name: "#{name} manager", business: business)
end

# Craete Test business, facilities and positions
test_business = Business.create(name: 'Test business')

Facility.create(name: 'Test facility', business: test_business)
EmployeePosition.create(name: 'Test employee position', business: test_business)
ManagerPosition.create(name: 'Test manager position', business: test_business)

# Create shifts
shifts_data = YAML.load_file("#{Rails.root}/db/import/shifts.yml")

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

# Create administrators
Administrator.create!(
  name: 'James Ramseier',
  email: Rails.application.credentials.users[:administrator][:email],
  password: Rails.application.credentials.users[:administrator][:password],
  password_confirmation: Rails.application.credentials.users[:administrator][:password],
  role: :administrator,
  business: business
)

Administrator.create!(
  name: 'Super Administrator',
  # email: Rails.application.credentials.users[:super_administrator][:email],
  # password: Rails.application.credentials.users[:super_administrator][:password],
  # password_confirmation: Rails.application.credentials.users[:super_administrator][:password],
  email: 'its@me.com',
  password: '123123123',
  password_confirmation: '123123123',
  role: :administrator,
  super_administrator: true,
  business: business
)

# Create email templates
default_email_templates_data = YAML.load_file("#{Rails.root}/db/import/default_email_templates.yml")
default_email_templates_data.each do |data|
  EmailTemplate.create(
    name: data['name'],
    key: data['key'],
    body: data['body']
  )
end

# Clear audits
Audited::Audit.delete_all
