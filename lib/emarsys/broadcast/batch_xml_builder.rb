require 'nokogiri'
module Emarsys
  module Broadcast
    class BatchXmlBuilder
      include Validation

      def build(batch)
        # raise ArgumentError, 'subject is required' unless string_present? 
        # raise ArgumentError, 'body is required' unless string_present? body
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.batch {
            xml.name batch.name
            xml.runDate format_time(batch.send_time)
            xml.properties {
              xml.property(key: :Sender){xml.text batch.sender}
              xml.property(key: :Language){xml.text 'en'}
              xml.property(key: :Encoding){xml.text 'UTF-8'}
              xml.property(key: :Domain){xml.text batch.sender_domain}
            }
            xml.subject batch.subject
            xml.html batch.body
          }
        end 
        builder.to_xml  
      end


      private 

      # def validate_options(options)
      #   raise ArgumentError, 'options can not be nil' unless options
      #   raise ArgumentError, 'name is required' unless string_present? options[:name]
      #   raise ArgumentError, 'send_time is required' if options[:send_time].nil?
      #   raise ArgumentError, 'sender is required' unless string_present? options[:sender]
      #   raise ArgumentError, 'sender must be a valid email' unless Email::validate options[:sender]
      # end

      def format_time(time)
        time.strftime("%Y-%m-%dT%H:%M:%S%z")
      end
    end
  end
end