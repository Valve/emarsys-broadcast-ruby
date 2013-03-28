require 'httpclient'
module Emarsys
  module Broadcast
    class HTTP
      include Validation
      def initialize(config)
        validate_config config
        @config = config
      end

      private

      def validate_config(config)
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