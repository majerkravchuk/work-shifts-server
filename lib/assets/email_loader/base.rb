module EmailLoader
  class Base
    attr_accessor :business, :user, :file, :result

    def initialize(business, user, file)
      @business = business
      @user = user
      @file = file
      @result = EmailLoader::Result.create(business: business, manager: user, status: :uploaded)
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
