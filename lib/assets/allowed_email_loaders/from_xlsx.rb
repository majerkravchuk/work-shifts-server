module AllowedEmailLoaders
  class FromXlsx < Base
    attr_accessor :xlsx_file

    def parse!
      @xlsx_file = Roo::Spreadsheet.open(file)
      @result = AllowedEmailLoading::Result.create(business: current_business, manager: current_user)

      @xlsx_file.sheet(0).each_row_streaming(offset: 1, pad_cells: true) do |xlsx_row|
        next if xlsx_row.all? { |c| c.nil? || c.value.nil? }

        name, email, role, position_name, facility_names = extract_fields(xlsx_row)

        row = result.rows.new(business: current_business, row: xlsx_row[0].coordinate.row)

        next unless validate_fields(row, email, role, position_name, facility_names)

        allowed_email = current_business.allowed_email.find_or_initialize_by(email: email)
        allowed_email.name = name
        allowed_email.role = role
        allowed_email.position = current_business.positions.where('LOWER(name) = ?', position_name.downcase).first

        if role == :employee
          facilities = current_business.facilities.where('LOWER(name) IN (?)', facility_names.map(&:downcase))
          allowed_email.allowed_facilities = facilities
        end

        if allowed_email.new_record?
          row.status = :created
          row.message = "email for [#{email}] successfully imported!"
        else
          row.status = :updated
          row.message = "email for [#{email}] successfully updated!"
        end

        allowed_email.save
        row.save
      end

      result
    end

    def extract_fields(xlsx_row)
      name = xlsx_row[0].value
      email = xlsx_row[1].value
      role = xlsx_row[2].value.downcase.to_sym
      position_name = xlsx_row[3].value
      facility_names = xlsx_row[4].value.split(',').map(&:strip)

      [name, email, role, position_name, facility_names]
    end
  end
end
