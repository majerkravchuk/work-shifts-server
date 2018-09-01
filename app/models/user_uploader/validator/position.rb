module UserUploader
  class Validator
    class Position < Validator::Base
      def validate!
        position = business.positions.where('LOWER(name) = ?', value.downcase).first

        if value.blank?
          reject_row('position can not be blank') if value.blank?

        elsif position.blank?
          reject_row("position [#{value}] does not exist")

        elsif current_user.manager?
          if position.is_a?(EmployeePosition) && current_user.employee_positions.exclude?(position)
            reject_row("you do not have access to the [#{value}] position")

          elsif position.is_a?(ManagerPosition)
            reject_row('you can not invite the manager')
          end
        end
      end
    end
  end
end
