module SecretSanta
  module Models
    class InvalidAssignmentError < StandardError; end

    class Assignment
      attr_reader :giver, :receiver

      def initialize(giver:, receiver:)
        @giver    = giver
        @receiver = receiver
        validate!
      end

      def same_pair?(other)
        giver == other.giver && receiver == other.receiver
      end

      private

      def validate!
        unless giver.is_a?(Employee)
          raise InvalidAssignmentError, "Giver must be an Employee"
        end

        unless receiver.is_a?(Employee)
          raise InvalidAssignmentError, "Receiver must be an Employee"
        end

        if giver == receiver
          raise InvalidAssignmentError, "Employee cannot be assigned to themselves"
        end
      end
    end
  end
end
