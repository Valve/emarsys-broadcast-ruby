module Emarsys
  module Broadcast
    class API

      def initialize
        config = Emarsys::Broadcast.configuration
        @sftp = SFTP.new config
        @http = HTTP.new config
      end

    end
  end
end