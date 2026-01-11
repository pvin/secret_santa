module SecretSanta
  class AssignmentEngine
    def initialize(employees:, rules:)
      @employees = employees
      @rules     = rules
    end

    def generate_assignments
      givers     = @employees.shuffle
      receivers  = @employees.shuffle
      assignments = []
      givers.each do |giver|
        receiver = find_valid_receiver_for(giver, receivers)
        unless receiver
          raise "No valid receiver found for #{giver.name}"
        end
        assignments << Models::Assignment.new(giver: giver, receiver: receiver)
        receivers.delete(receiver)
      end
      assignments
    end

    private

    def find_valid_receiver_for(giver, available_receivers)
      available_receivers.each do |receiver|
        begin
          assignment = Models::Assignment.new(giver: giver,receiver: receiver)
          return receiver if valid_assignment?(assignment)
        rescue Models::InvalidAssignmentError
          next
        end
      end
      nil
    end

    def valid_assignment?(assignment)
      @rules.all? {|rule| rule.allowed?(assignment)}
    end
  end
end
