namespace :secret_santa do
  desc "Generate Secret Santa assignments"

  task generate: :environment do
    employees_csv = ENV.fetch('EMPLOYEES', 'employees.csv')
    output_csv    = ENV.fetch('OUTPUT', 'output.csv')
    previous_csvs = ENV['PREVIOUS'] # optional

    unless File.exist?(employees_csv)
      abort "Error: employees CSV not found at #{employees_csv}"
    end

    previous_csv_files =
      previous_csvs.to_s.split(",").map(&:strip).select do |file|
        if File.exist?(file)
          true
        else
          puts "Warning: Previous assignments CSV not found: #{file}"
          false
        end
      end

    employees = Csv::Reader.read_employees(employees_csv)
    previous_assignments = Csv::Reader.read_assignments(previous_csv_files)
    
    SecretSanta::Generator.new(
      employees: employees,
      previous_assignments: previous_assignments,
      reader: Csv::Reader,
      writer: Csv::Writer
    ).run(output_path: output_csv)

    puts "Secret Santa assignments generated successfully!"
    puts "Output CSV: #{output_csv}"
  end
end
