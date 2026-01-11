module SecretSanta
  module Rules
    class NoSelfAssignmentRule < BaseRule
      def allowed?(assignment)
        giver = assignment.giver
        receiver = assignment.receiver
        giver != receiver
      end
    end
  end
end
