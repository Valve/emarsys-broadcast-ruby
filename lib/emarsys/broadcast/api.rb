module Emarsys
  module Broadcast
    class API

      def initialize
        @config = Emarsys::Broadcast.configuration
        @sftp = SFTP.new @config
        @http = HTTP.new @config
      end

      def send_batch(batch)
        batch = supplement_batch_from_config(batch)
        create_batch(batch)
        upload_recipients(batch.recipients_path)
        trigger_import(batch)
      end

      def create_batch(batch)
        batch_xml = BatchXmlBuilder.new.build(batch)
        @http.post("#{@config.api_base_path}/batches/#{batch.name}", batch_xml)
      end

      def upload_recipients(recipients_path)
        @sftp.upload_file(recipients_path, File.basename(recipients_path))
      end

      def trigger_import(batch)
        import_xml = XmlBuilder.new.import_xml(File.basename(batch.recipients_path))
        @http.post("#{@config.api_base_path}/batches/#{batch.name}/import", import_xml)
      end

      def get_senders
        response = @http.get("#{@config.api_base_path}/senders")
        Nokogiri::XML(response).xpath('//sender').map do |node|
          Sender.new(node.attr('id'), node.xpath('name').text, node.xpath('address').text)
        end
      end

      private

      def supplement_batch_from_config(batch)
        batch.recipients_path ||= @config.recipients_path
        batch.send_time ||= Time.now
        batch.sender ||= @config.sender
        batch.sender_domain ||= @config.sender_domain
        batch
      end
    end
  end
end