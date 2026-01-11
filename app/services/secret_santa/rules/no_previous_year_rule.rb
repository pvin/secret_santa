module SecretSanta
  module Rules
    class NoPreviousYearRule < BaseRule
      def initialize(previous_assignments = [])
        @previous_assignments = previous_assignments
      end

      def allowed?(assignment)
        @previous_assignments.none? do |previous|
          same_giver?(assignment, previous) && same_receiver?(assignment, previous)
        end
      end

      private

      def same_giver?(current, previous)
        current.giver == previous.giver
      end

      def same_receiver?(current, previous)
        current.receiver == previous.receiver
      end
    end
  end
end
