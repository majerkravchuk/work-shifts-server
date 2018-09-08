module Uploadable
  extend ActiveSupport::Concern

  module ClassMethods
    def from_uploader_row(business, row, fields)
      user = business.users.find_or_initialize_by(email: fields[:email])

      user.invitation_status = :uploaded if user.invitation_status.nil?
      user.name = fields[:name]
      user.type = "User::#{fields[:role].capitalize}"
      user.position = business.positions.where('LOWER(name) = ?', fields[:position].downcase).first

      if fields[:role] == 'employee'
        facilities = business.facilities.where('LOWER(name) IN (?)', fields[:facilities].map(&:downcase))
        user.facilities = facilities
      end

      if user.new_record?
        row.status = :created
        row.message = "User with email [#{fields[:email]}] successfully uploaded!"
      else
        row.status = :updated
        row.message = "User with email [#{fields[:email]}] successfully updated!"
      end

      row.save
      user.save

      user
    end
  end
end
