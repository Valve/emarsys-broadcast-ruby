module Emarsys
  module Broadcast
    module Validation
      def string_present? value
        !value.to_s.strip.empty?
      end

      def within_range? value, range
        raise ArgumentError, 'range is required' if range.nil? || !range.is_a?(::Range)
        range.include? value
      end
    end
  end
end