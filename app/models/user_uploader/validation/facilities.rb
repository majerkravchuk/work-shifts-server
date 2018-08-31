module UserUploader
  module Validation
    class Facilities < Validation::Base
      def validate!
        facilitiy_couples = value.map do |facility_name|
          [business.facilities.where('LOWER(name) = ?', facility_name.downcase).first, facility_name]
        end

        if facilitiy_couples.map(&:first).any?(&:nil?)
          facility_names = facilitiy_couples.select { |f| f.first.nil? }.map(&:second).join ', '
          reject_row("facilities [#{facility_names}] do not exist")
          return false
        end

        true
      end
    end
  end
end
