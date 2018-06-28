module EmailLoader
  module Validation
    class Position < Validation::Base
      def validate!
        if value.blank?
          reject_row("email can't be blank")
          return false
        end

        position = business.positions.where('LOWER(name) = ?', value.downcase).first

        if position.blank?
          reject_row("position [#{value}] does not exist")
          return false
        end

        if position.kind_of?(EmployeePosition) && user.employee_positions.exclude?(position)
          reject_row("you do not have access to the [#{value}] position")
          return false
        end

        if position.kind_of?(ManagerPosition) && user.position != position
          reject_row('you can not invite the manager with a different position from yours')
          return false
        end

        true
      end
    end
  end
end
