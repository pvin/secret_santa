module SecretSanta
  module Models
    class Employee
      attr_reader :name, :email

      def initialize(name:, email:)
        @name  = normalize_name(name)
        @email = normalize_email(email)
        validate!
      end
      
      def identifier
        email
      end

      def ==(other)
        other.is_a?(Employee) && identifier == other.identifier
      end
      alias eql? ==

      def hash
        identifier.hash
      end

      private

      def validate!
        raise ArgumentError, "Employee name cannot be blank" if name.empty?
        raise ArgumentError, "Employee email cannot be blank" if email.empty?
        raise ArgumentError, "Invalid email format: #{email}" unless valid_email?
      end

      def valid_email?
        /\A[^@\s]+@[^@\s]+\z/.match?(email)
      end

      def normalize_name(value)
        value.to_s.strip
      end

      def normalize_email(value)
        value.to_s.strip.downcase
      end
    end
  end
end
