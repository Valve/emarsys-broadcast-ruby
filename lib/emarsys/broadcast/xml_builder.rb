require 'nokogiri'
module Emarsys
  module Broadcast
    class XmlBuilder
      include Validation
      attr_accessor :name
      def initialize(options)
        validate_options options
        @name = options[:name]
      end

      private 

      def validate_options(options)
        raise ArgumentError, 'options can not be nil' unless options
        raise ArgumentError, 'name is required' unless string_present? options[:name]
      end
 
    end
  end
end