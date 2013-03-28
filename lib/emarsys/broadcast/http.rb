require 'httpclient'
module Emarsys
  module Broadcast
    class HTTP
      def initialize(config)
        validate_config config
        @config = config
      end

      private

      def validate_config(config)
        raise ConfigurationError, 'http_host must be configured' if config.http_host.nil? || config.http_host.empty?
        raise ConfigurationError, 'http_user must be configured' if config.http_user.nil? || config.http_user.empty?
        raise ConfigurationError, 'http_password must be configured' if config.http_password.nil? || config.http_password.empty?
        raise ConfigurationError, 'http_port must be present' unless config.http_port
        if (!config.http_port.is_a?(Integer) || !((1..65535).include? config.http_port))
          raise ConfigurationError, 'http_port must be integer between 1 and 65535' 
        end
      end
    end
  end
end