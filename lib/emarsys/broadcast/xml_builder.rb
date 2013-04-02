require 'nokogiri'
module Emarsys
  module Broadcast
    class XmlBuilder
      include Validation

      def import_xml(remote_path)
        xml = Nokogiri::XML::Builder.new do |xml|
          xml.importRequest {
            xml.filePath remote_path
          }
        end
        xml.to_xml
      end

      private 

      def validate_options(options)
        raise ArgumentError, 'options can not be nil' unless options
        raise ArgumentError, 'name is required' unless string_present? options[:name]
      end
 
    end
  end
end