module UserUploader
  class Validator
    class Email < Validator::Base
      def validate!
        if value.blank?
          reject_row("email can't be blank")

        elsif !(/\A[^@\s]+@[^@\s]+\z/.match? value)
          reject_row("email [#{value}] is not valid")

        elsif business.users.where(email: value, invitation_status: :invited).any?
          reject_row("user with email [#{value}] is already invited")

        elsif business.users.where(email: value).where.not(invitation_status: :uploaded).any?
          reject_row("user with email [#{value}] is already registered")
        end
      end
    end
  end
end
