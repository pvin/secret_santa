module SecretSanta
  class Generator
    def initialize(employees:, previous_assignments: [], reader:, writer:)
      @employees = employees
      @previous_assignments = previous_assignments
      @reader = reader
      @writer = writer
    end

    def run(output_path:)
      rules = build_rules
      engine = AssignmentEngine.new(employees: @employees, rules: rules)
      assignments = engine.generate_assignments
      @writer.new(output_path).write(assignments)
      assignments
    end

    private

    def build_rules
      rules = []
      rules << Rules::NoSelfAssignmentRule.new
      rules << Rules::NoPreviousYearRule.new(@previous_assignments)
      rules
    end
  end
end