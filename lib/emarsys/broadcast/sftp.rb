require 'net/sftp'
module Emarsys
  module Broadcast
    class SFTP
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
        raise ConfigurationError, 'sftp_host must be configured' if config.sftp_host.nil? || config.sftp_host.empty?
        raise ConfigurationError, 'sftp_user must be configured' if config.sftp_user.nil? || config.sftp_user.empty?
        raise ConfigurationError, 'sftp_password must be configured' if config.sftp_password.nil? || config.sftp_password.empty?
        raise ConfigurationError, 'sftp_port must be present' unless config.sftp_port
        if (!config.sftp_port.is_a?(Integer) || !((1..65535).include? config.sftp_port))
          raise ConfigurationError, 'sftp_port must be integer between 1 and 65535' 
        end
      end
    end
  end
end