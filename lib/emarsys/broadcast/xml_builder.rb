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

      def import_xml
        xml = Nokogiri::XML::Builder.new do |xml|
          xml.importRequest {
            xml.filePath @name
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