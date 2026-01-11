namespace :secret_santa do
  desc "Generate Secret Santa assignments"

  task generate: :environment do
    employees_csv = ENV['EMPLOYEES'] || "employees.csv"
    output_csv    = ENV['OUTPUT']    || "output.csv"
    previous_csvs = ENV['PREVIOUS']

    unless File.exist?(employees_csv)
      puts "Error: employees CSV not found at #{employees_csv}"
      exit(1)
    end

    if output_csv.nil? || output_csv.strip.empty?
      puts "Error: output CSV path must be specified"
      exit(1)
    end

    previous_csv_files = if previous_csvs
      previous_csvs.split(",").map(&:strip).select { |file|
        if File.exist?(file)
          true
        else
          puts "Warning: Previous assignments CSV not found at #{file}. Skipping this file."
          false
        end
      }
    else
      []
    end

    if previous_csvs && previous_csv_files.empty?
      puts "Warning: No valid previous assignments CSVs found. Skipping previous-year rule."
    end

    begin
      employees = Csv::Reader.read_employees(employees_csv)
      previous_assignments = Csv::Reader.read_assignments(previous_csv_files)
      generator = SecretSanta::Generator.new(employees: employees, previous_assignments: previous_assignments, reader: Csv::Reader, writer: Csv::Writer)
      generator.run(output_path: output_csv)
      puts "Secret Santa assignments generated successfully!"
      puts "Output CSV: #{output_csv}"
    rescue StandardError => e
      puts "Error generating Secret Santa assignments: #{e.message}"
      exit(1)
    end
  end
end
