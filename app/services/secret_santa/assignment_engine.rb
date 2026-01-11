module SecretSanta
  class AssignmentEngine
    def initialize(employees:, rules:)
      @employees = employees
      @rules = rules
    end

    def generate_assignments
      givers = @employees.shuffle
      receivers = @employees.shuffle

      assignments = []

      givers.each do |giver|
        receiver = find_valid_receiver_for(giver, receivers, assignments)
        raise "No valid receiver found for #{giver.name}" unless receiver
        # binding.pry
        assignments << SecretSanta::Models::Assignment.new(giver: giver, receiver: receiver)
        receivers.delete(receiver)
      end

      assignments
    end

    private

    def find_valid_receiver_for(giver, available_receivers, current_assignments)
      available_receivers.find do |receiver|
        assignment = SecretSanta::Models::Assignment.new(giver: giver, receiver: receiver)
        valid_assignment?(assignment)
      end
    end

    def valid_assignment?(assignment)
      @rules.all? {|rule| rule.allowed?(assignment)}
    end
  end
end
