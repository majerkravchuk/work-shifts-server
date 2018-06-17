module ActiveAdmin
  module Extensions
    module InvitationLoaders
      class Base
        attr_accessor :file, :current_user, :current_business, :result

        def initialize(file, current_user, current_business)
          @file = file
          @current_user = current_user
          @current_business = current_business
          @result = nil
        end

        def parse!
          raise RuntimeError, 'not implemented!'
        end

        def extraxt_fields
          raise RuntimeError, 'not implemented!'
        end

        def validate_fields(row, email, role, position_name, facility_names)
          position = current_business.positions.where('LOWER(name) = ?', position_name.downcase).first

          unless /\A[^@\s]+@[^@\s]+\z/.match(email)
            row.status = :rejected
            row.message = "email [#{email}] is not valid"
            row.save
            return false
          end

          if current_business.users.find_by(email: email).present?
            row.status = :rejected
            row.message = "user with email [#{email}] already registered"
            row.save
            return false
          end

          if %i[employee manager].exclude?(role)
            row.status = :rejected
            row.message = "role [#{role}] does not exist"
            row.save
            return false
          end

          if position.blank?
            row.status = :rejected
            row.message = "position [#{position_name}] does not exist"
            row.save
            return false
          end

          if role == :manager && current_user.manager? && position != current_user.position
            row.status = :rejected
            row.message = 'manager can not invite the manager with a different position'
            row.save
            return false
          end

          if role == :employee && current_user.allowed_employee_positions.exclude?(position)
            row.status = :rejected
            row.message = "you do not have access to the [#{position_name}] position"
            row.save
            return false
          end

          facilitiy_couples = facility_names.map do |facility_name|
            [current_business.facilities.where('LOWER(name) = ?', facility_name.downcase).first, facility_name]
          end

          if facilitiy_couples.any? { |f| f.first.nil? }
            row.status = :rejected
            facility_names = facilitiy_couples.select { |f| f.first.nil? }.map(&:second).join ", "
            row.message = "facilities [#{facility_names}] do not exist"
            row.save
            return false
          end

          true
        end
      end
    end
  end
end

