module Emarsys
  module Broadcast
    class ValidationError < StandardError
      attr_reader :errors
      def initialize(message, errors)
        super(message)
        @errors = errors
      end
    end
  end
end
