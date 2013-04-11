module Emarsys
  module Broadcast
    class API

      def initialize
        @config = Emarsys::Broadcast.configuration
        @sftp = SFTP.new @config
        @http = HTTP.new @config
        @xml_builder = XmlBuilder.new
      end

      def send_batch(batch)
        batch = supplement_batch_from_config(batch)
        validate_batch(batch)
        validate_sender(batch.sender)
        create_batch(batch)
        upload_recipients(batch.recipients_path)
        trigger_import(batch)
      end

      def create_batch(batch)
        emarsys_sender = get_sender(batch.sender)
        batch.sender_id = emarsys_sender.id
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

      def get_sender(email)
        get_senders.find{|s| s.address == email}
      end

      def create_sender(sender)
        sender_xml = @xml_builder.sender_xml(sender)
        @http.put("#{@config.api_base_path}/senders/#{sender.id}", sender_xml)
      end

      def sender_exists?(email)
        get_senders.any?{|s|s.address == email}
      end

      private

      def supplement_batch_from_config(batch)
        batch.recipients_path ||= @config.recipients_path
        batch.send_time ||= Time.now
        batch.sender ||= @config.sender
        batch.sender_domain ||= @config.sender_domain
        batch.import_delay_hours ||= @config.import_delay_hours
        batch
      end

      def validate_batch(batch)
        raise ValidationError.new('Batch is invalid', batch.errors.full_messages) unless batch.valid?
      end

      def validate_sender(email)
        msg = 'This email is not registered with Emarsys as a sender, register it with `create_sender` api call'
        raise ValidationError, msg, [msg] unless sender_exists? email 
      end
    end
    class ApiError < StandardError; end
  end
end