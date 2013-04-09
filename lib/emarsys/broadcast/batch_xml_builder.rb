require 'nokogiri'
module Emarsys
  module Broadcast
    class BatchXmlBuilder

      def build(batch)
        raise ArgumentError, 'batch is required' unless batch
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.batch {
            xml.name batch.name
            xml.runDate format_time(batch.send_time)
            xml.properties {
              xml.property(key: :Sender){xml.text batch.sender_id}
              xml.property(key: :Language){xml.text 'en'}
              xml.property(key: :Encoding){xml.text 'UTF-8'}
              xml.property(key: :Domain){xml.text batch.sender_domain}
            }
            xml.subject batch.subject
            xml.html batch.body_html
            xml.text batch.body_text
          }
        end 
        builder.to_xml
      end


      private 

      def format_time(time)
        time.strftime("%Y-%m-%dT%H:%M:%S%z")
      end
    end
  end
end