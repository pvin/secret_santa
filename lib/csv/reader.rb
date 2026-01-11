require 'csv'

module Csv
  class Reader
    class << self
      def read_employees(file_path)
        validate_file!(file_path)

        CSV.read(file_path, headers: true).map do |row|
          SecretSanta::Models::Employee.new(
            name: row['Employee_Name'],
            email: row['Employee_EmailID']
          )
        end
      end

      def read_assignments(file_paths)
        Array(file_paths).flat_map do |file_path|
          validate_file!(file_path)

          CSV.read(file_path, headers: true).map do |row|
            giver = SecretSanta::Models::Employee.new(
              name: row['Employee_Name'],
              email: row['Employee_EmailID']
            )

            receiver = SecretSanta::Models::Employee.new(
              name: row['Secret_Child_Name'],
              email: row['Secret_Child_EmailID']
            )

            SecretSanta::Models::Assignment.new(
              giver: giver,
              receiver: receiver
            )
          end
        end
      end

      private

      def validate_file!(file_path)
        raise "CSV file not found: #{file_path}" unless File.exist?(file_path)
      end
    end
  end
end