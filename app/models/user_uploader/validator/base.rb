module UserUploader
  class Validator
    class Base
      attr_accessor :business, :current_user, :row, :value

      def initialize(business, current_user, row, value)
        @business = business
        @current_user = current_user
        @row = row
        @value = value
      end

      def reject_row(message)
        row.status = :rejected
        row.message = message
        row.save
      end
    end
  end
end
