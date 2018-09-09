module Uploadable
  extend ActiveSupport::Concern

  def change_position(new_position)
    facilities.clear if persisted? && position.employee? && new_position.manager?
    self.position = new_position
  end

  module ClassMethods
    def from_uploader_row(business, row, fields)
      worker = business.workers.find_or_initialize_by(email: fields[:email])
      position = business.positions.where('LOWER(name) = ?', fields[:position].downcase).first

      worker.change_position(position) if worker.position != position

      worker.invitation_status = :uploaded if worker.invitation_status.nil?
      worker.name = fields[:name]

      if position.employee?
        facilities = business.facilities.where('LOWER(name) IN (?)', fields[:facilities].map(&:downcase))
        worker.facilities = facilities
      end

      if worker.new_record?
        row.status = :created
        row.message = "User with email [#{fields[:email]}] successfully uploaded!"
      else
        row.status = :updated
        row.message = "User with email [#{fields[:email]}] successfully updated!"
      end

      row.save
      worker.save

      worker
    end
  end
end
