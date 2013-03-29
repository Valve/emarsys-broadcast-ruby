require 'httpclient'
module Emarsys
  module Broadcast
    class HTTP
      include Validation

      def initialize(config)
        validate_config config
        @config = config
        @client = HTTPClient.new
      end

      def post(path, xml)
        raise ArgumentError, 'path is required' unless string_present? path
        raise ArgumentError, 'xml is required' unless string_present? xml
        url = @config.http_host + path
        @client.set_basic_auth(url, @config.http_user, @config.http_password)
        @client.post(url, xml, 'Content-Type' => 'application/xml')
      end

      private

      def validate_config(config)
        raise ConfigurationError, 'configuration is nil, did you forget to configure the gem?' unless config
        raise ConfigurationError, 'http_host must be configured' unless string_present? config.http_host
        raise ConfigurationError, 'http_user must be configured' unless string_present? config.http_user
        raise ConfigurationError, 'http_password must be configured' unless string_present? config.http_password
        unless within_range? config.http_port, 1..65535
          raise ConfigurationError, 'http_port must be integer between 1 and 65535' 
        end
      end
    end
  end
end