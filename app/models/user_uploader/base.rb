module UserUploader
  class Base
    attr_accessor :business, :current_user, :file, :result

    def initialize(business, current_user, file)
      @business = business
      @current_user = current_user
      @file = file
      @result = UserUploader::Result.create(business: business, user: current_user, status: :uploaded)
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
