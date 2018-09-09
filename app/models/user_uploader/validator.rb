module UserUploader
  class Validator
    attr_accessor :business, :current_user, :row, :fields

    def initialize(business, current_user, row, fields)
      @business = business
      @current_user = current_user
      @row = row
      @fields = fields
    end

    def validate!
      %i[email position facilities].each do |type|
        class_name = "UserUploader::Validator::#{type.to_s.capitalize}"
        class_name.constantize.new(business, current_user, row, fields[type]).validate!

        return false if row.rejected?
      end
    end
  end
end
