module SecretSanta
  module Rules
    class BaseRule
      def initialize(context = {})
        @context = context
      end
      
      def allowed?(_assignment)
        raise NotImplementedError, "#{self.class.name} must implement #allowed?"
      end

      protected

      attr_reader :context
    end
  end
end
