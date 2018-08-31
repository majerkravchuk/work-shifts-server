module UserUploader
  module Uploaders
    class Base
      attr_accessor :business, :user, :file, :result

      def initialize(business, user, file)
        @business = business
        @user = user
        @file = file
        @result = UserUploader::Result.create(business: business, user: user, status: :uploaded)
        @result.file.attach(file)
      end

      def parse!
        raise RuntimeError
      end

      def extraxt_fields
        raise RuntimeError
      end
    end
  end
end
