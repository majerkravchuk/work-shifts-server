module UserUploader
  class Validator
    class Role < Validator::Base
      def validate!
        if value.blank?
          reject_row('role can not be blank')

        elsif User.roles.keys.exclude?(value)
          reject_row("role [#{value}] does not exist")

        elsif current_user.manager? && value == 'manager'
          reject_row("you can't invite the manager")
        end
      end
    end
  end
end
