module EmailLoader
  module Validation
    class Validator
      attr_accessor :business, :user, :row, :fields

      def initialize(business, user, row, fields)
        @business = business
        @user = user
        @row = row
        @fields = fields
      end

      def validate!
        email = EmailLoader::Validation::Email.new(business, user, row, fields[:email]).validate!
        role = EmailLoader::Validation::Role.new(business, user, row, fields[:role]).validate!
        position = EmailLoader::Validation::Position.new(business, user, row, fields[:position]).validate!
        facilities = EmailLoader::Validation::Facilities.new(business, user, row, fields[:facilities]).validate!

        email && role && position && facilities
      end
    end
  end
end
