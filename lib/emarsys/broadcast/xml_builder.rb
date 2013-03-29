require 'nokogiri'
module Emarsys
  module Broadcast
    class XmlBuilder
      attr_accessor :name, :send_time, :sender

      def initialize(options)
        validate_options options
        @name = options[:name]
        @send_time = options[:send_time]
        @sender = options[:sender]
      end

      def build(subject, body)
        raise ArgumentError, 'subject is required' if subject.nil? || subject.empty?
        raise ArgumentError, 'body is required' if body.nil? || body.empty?
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.batch {
            xml.name @name
            xml.runDate format_time(@send_time)
            xml.properties {
              xml.property(key: :Sender) { xml.text! @sender }
              xml.property(key: :Language) { xml.text! 'en' }
              xml.property(key: :Encoding) { xml.text! 'UTF-8' }
              xml.property(key: :Domain) { xml.text! 'e3.emarsys.net' }
            }
            xml.subject subject
            xml.html body
          }
        end 
        builder.to_xml  
      end


      private 

      def validate_options(options)
        raise ArgumentError, 'options can not be nil' if options.nil?
        raise ArgumentError, 'name is required' if (options[:name].nil? || options[:name].empty?)
        raise ArgumentError, 'send_time is required' if (options[:send_time].nil?)
        raise ArgumentError, 'sender is required' if (options[:sender].nil? || options[:sender].empty?)
        raise ArgumentError, 'sender must be valid email' unless Email::validate options[:sender]
      end

      def format_time(time)
        time.strftime("%Y-%m-%dT%H:%M:%S%z")
      end
    end
  end
end