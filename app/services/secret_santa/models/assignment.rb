module SecretSanta
  module Models
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
        raise ArgumentError, "Giver must be an Employee" unless giver.is_a?(Employee)
        raise ArgumentError, "Receiver must be an Employee" unless receiver.is_a?(Employee)

        if giver == receiver
          raise ArgumentError, "Employee cannot be assigned to themselves"
        end
      end
    end
  end
end
