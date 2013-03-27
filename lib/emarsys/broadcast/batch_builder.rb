require 'nokogiri'
module Emarsys
  module Broadcast
    class BatchBuilder
      attr_accessor :name, :send_time, :sender

      def initialize(options)
        validate_options options
        @name = options[:name]
        @send_time = options[:send_time]
        @sender = options[:sender]
      end


      private 

      def validate_options(options)
        raise ArgumentError, 'options can not be nil' if options.nil?
        raise ArgumentError, 'name is required' if (options[:name].nil? || options[:name].empty?)
        raise ArgumentError, 'send_time is required' if (options[:send_time].nil?)
        raise ArgumentError, 'sender is required' if (options[:sender].nil? || options[:sender].empty?)
        raise ArgumentError, 'sender must be valid email' unless Email::validate options[:sender]
      end
    end
  end
end