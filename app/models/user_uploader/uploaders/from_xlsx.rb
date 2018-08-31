module UserUploader
  module Uploaders
    class FromXlsx < Base
      attr_accessor :xlsx_file

      def parse!
        open_xlsx_file
        return @result if @result.rejected?

        row_id = 0

        @xlsx_file.sheet(0).each_row_streaming(offset: 1, pad_cells: true) do |xlsx_row|
          row_id += 1
          next if xlsx_row.all? { |c| c.nil? || c.value.nil? }

          fields = extract_fields(xlsx_row)
          row = result.rows.new(business: business, row: row_id)

          validator = UserUploader::Validation::Validator.new(business, user, row, fields)
          next unless validator.validate!

          User.from_uploader_row(business, row, fields)
        end

        result
      end

      private

      def open_xlsx_file
        begin
          @xlsx_file = Roo::Spreadsheet.open(file)
        rescue
          @xlsx_file = nil
        end

        if @xlsx_file.nil?
          @result.update(status: :rejected)
          @result.rows.create(
            business: business,
            row: 0,
            status: :rejected,
            message: 'Unsupported file format'
          )
        end
      end

      def extract_fields(xlsx_row)
        {
          name:       safe_value(xlsx_row, 0),
          email:      safe_value(xlsx_row, 1),
          role:       safe_value(xlsx_row, 2).downcase.to_sym,
          position:   safe_value(xlsx_row, 3),
          facilities: safe_value(xlsx_row, 4).split(',').map(&:strip)
        }
      end

      def safe_value(row, cell)
        row[cell].try(:value) || ''
      end
    end
  end
end
