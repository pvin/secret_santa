require 'csv'

module Csv
  class Writer
    HEADERS = ['Employee_Name', 'Employee_EmailID','Secret_Child_Name','Secret_Child_EmailID'].freeze

    def initialize(file_path)
      @file_path = file_path
    end

    def write(assignments)
      validate_assignments!(assignments)

      ::CSV.open(@file_path, 'w', write_headers: true, headers: HEADERS) do |csv|
        assignments.each do |assignment|
          csv << build_row(assignment)
        end
      end
    rescue StandardError => e
      raise StandardError, "Failed to write output CSV #{@file_path}: #{e.message}"
    end

    private

    def build_row(assignment)
      [
        assignment.giver.name,
        assignment.giver.email,
        assignment.receiver.name,
        assignment.receiver.email
      ]
    end

    def validate_assignments!(assignments)
      unless assignments.is_a?(Array)
        raise ArgumentError, 'Assignments must be an array'
      end

      if assignments.empty?
        raise ArgumentError, 'Assignments list is empty'
      end
    end
  end
end
