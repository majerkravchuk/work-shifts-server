module UserUploader
  module Validation
    class Base
      attr_accessor :business, :user, :row, :value

      def initialize(business, user, row, value)
        @business = business
        @user = user
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
