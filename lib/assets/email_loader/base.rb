module EmailLoader
  class Base
    attr_accessor :business, :user, :file, :result

    def initialize(business, user, file)
      @business = business
      @user = user
      @file = file
      @result = nil
    end

    def parse!
      raise RuntimeError
    end

    def extraxt_fields
      raise RuntimeError
    end
  end
end
