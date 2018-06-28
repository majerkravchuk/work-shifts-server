module EmailLoader
  module Validation
    class Email < Validation::Base
      def validate!
        if value.blank?
          reject_row("email can't be blank")
          return false
        end

        unless /\A[^@\s]+@[^@\s]+\z/.match? value
          reject_row("email [#{value}] is not valid")
          return false
        end

        if business.users.find_by(email: value).present?
          reject_row("user with email [#{email}] already registered")
          return false
        end

        true
      end
    end
  end
end
