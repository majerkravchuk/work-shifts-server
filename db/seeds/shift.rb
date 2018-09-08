require "#{Rails.root}/db/seeds/base"

module Seeds
  class Shift < Base
    def seed!
      shifts_data = YAML.load_file("#{Rails.root}/db/import/shifts.yml")

      ::Business.all.each do |business|
        shifts_data.each do |data|
          position = business.employee_positions.find_by_name(data['position_name'])

          data['facilities'].each do |facility_data|
            facility = business.facilities.find_by_name(facility_data['name'])

            facility_data['shifts'].each do |shift_data|
              shift = ::Shift.create(
                business: business,
                facility: facility,
                position: position,
                name: shift_data['name'],
                start_time: shift_data['start_time'],
                end_time: shift_data['end_time']
              )
              log(shift)
            end
          end
        end
      end
    end
  end
end
