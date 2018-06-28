module EmailLoader
  module Validation
    class Role < Validation::Base
      def validate!
        if value.blank?
          reject_row("email can't be blank")
          return false
        end

        if %i[employee manager].exclude?(value)
          reject_row("role [#{value}] does not exist")
          return false
        end

        true
      end
    end
  end
end
