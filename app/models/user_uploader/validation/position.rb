module UserUploader
  module Validation
    class Position < Validation::Base
      def validate!
        if value.blank?
          reject_row("position can't be blank")
          return false
        end

        position = business.positions.where('LOWER(name) = ?', value.downcase).first

        if position.blank?
          reject_row("position [#{value}] does not exist")
          return false

        elsif position.is_a?(EmployeePosition) && !user.administrator? && user.employee_positions.exclude?(position)
          reject_row("you do not have access to the [#{value}] position")
          return false

        elsif position.is_a?(ManagerPosition) && !user.administrator? && user.position != position
          reject_row('you can not invite the manager with a different position from yours')
          return false
        end

        true
      end
    end
  end
end
