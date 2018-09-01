module UserUploader
  class Validator
    class Facilities < Validator::Base
      def validate!
        facility_couples = value.map do |facility_name|
          [business.facilities.where('LOWER(name) = ?', facility_name.downcase).first, facility_name]
        end

        if facility_couples.map(&:first).any?(&:nil?)
          facility_names = facility_couples.select { |f| f.first.nil? }.map(&:second).join ', '
          reject_row("facilities [#{facility_names}] do not exist")
        end
      end
    end
  end
end
