module UserUploader
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

        if business.users.where(email: value).where.not(invitation_status: %i[uploaded invited]).any?
          reject_row("user with email [#{value}] already registered")
          return false
        end

        true
      end
    end
  end
end
