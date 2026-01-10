require 'csv'

module CSV
  class Reader
    def initialize(file_path)
      @file_path = file_path
      validate_file!
    end

    def employees
      rows = read_csv
      rows.map do |row|
        Employee.new(name: row['Employee_Name'], email: row['Employee_EmailID'])
      end
    end

    def previous_assignments
      rows = read_csv
      rows.map do |row|
        Assignment.new(giver_name: row['Employee_Name'], giver_email: row['Employee_EmailID'],receiver_name: row['Secret_Child_Name'], receiver_email: row['Secret_Child_EmailID'])
      end
    end

    private

    def validate_file!
      unless File.exist?(@file_path)
        raise StandardError, "CSV file not found: #{@file_path}"
      end
    end

    def read_csv
      rows = []
      begin
        CSV.foreach(@file_path, headers: true) do |row|
          if row.to_hash.values.any?(&:nil?)
            raise StandardError, "CSV file #{@file_path} contains missing values"
          end
          rows << row.to_hash
        end
      rescue CSV::MalformedCSVError => e
        raise StandardError, "Malformed CSV file #{@file_path}: #{e.message}"
      end

      rows
    end
  end
end
