require 'net/sftp'
module Emarsys
  module Broadcast
    class SFTP
      include Validation
      
      def initialize(config)
        validate_config config
        @config = config
      end

      def upload_file(local_path, remote_path)
        Net::SFTP.start(@config.sftp_host, @config.sftp_user, password: @config.sftp_password) do |sftp|
          sftp.upload!(local_path, remote_path)
        end
      end

      private

      def validate_config(config)
        raise ConfigurationError, 'configuration is nil, did you forget to configure the gem?' unless config
        raise ConfigurationError, 'sftp_host must be configured' unless string_present? config.sftp_host
        raise ConfigurationError, 'sftp_user must be configured' unless string_present? config.sftp_user
        raise ConfigurationError, 'sftp_password must be configured' unless string_present? config.sftp_password
        unless within_range? config.sftp_port, 1..65535
          raise ConfigurationError, 'sftp_port must be integer between 1 and 65535' 
        end
      end
    end
  end
end