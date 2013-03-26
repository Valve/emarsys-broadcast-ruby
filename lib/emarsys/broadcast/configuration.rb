module Emarsys
  module Broadcast
    class ConfigurationError < StandardError; end


    class Configuration
      attr_accessor :sftp_host, :sftp_user, :sftp_password, :sftp_port

      def initialize
        @sftp_port = 22
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
