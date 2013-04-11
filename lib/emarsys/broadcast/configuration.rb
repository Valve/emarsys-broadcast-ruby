module Emarsys
  module Broadcast
    class ConfigurationError < StandardError; end


    class Configuration
      attr_accessor \
        :sftp_host, 
        :sftp_user, 
        :sftp_password, 
        :sftp_port,
        :api_host, 
        :api_base_path,
        :api_user, 
        :api_password, 
        :api_port,
        :api_timeout,
        :sender,
        :sender_domain,
        :recipients_path,
        # https://e3.emarsys.net/bmapi/v2/doc/Properties.html#ImportDelay
        :import_delay_hours


      def initialize
        @sftp_host = 'e3.emarsys.net'
        @sftp_port = 22
        @api_host = 'e3.emarsys.net'
        @api_base_path = '/bmapi/v2'
        @api_port = 80
        @api_timeout = 600 #10 minutes
        @import_delay_hours = 1
      end
    end

    class << self
      attr_accessor :configuration
    end

    def self.configure
      self.configuration ||= Configuration.new
      yield configuration
      configuration
    end
  end
end
