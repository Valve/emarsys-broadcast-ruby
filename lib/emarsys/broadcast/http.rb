require 'net/http'
module Emarsys
  module Broadcast
    class HTTP
      include Validation

      def initialize(config)
        validate_config config
        @config = config
      end

      def post(path, xml)
        request(path, xml, :post)
      end

      def put(path, xml)
        request(path, xml, :put)
      end

      def get(path)
        request(path, nil, :get)
      end


      private

      def request(path, data, method)
        https = Net::HTTP.new(@config.api_host, Net::HTTP.https_default_port)
        https.read_timeout = @config.api_timeout
        https.use_ssl = true
        https.verify_mode = OpenSSL::SSL::VERIFY_NONE

        https.start do |http|
          case method.downcase.to_sym
          when :post
            req = Net::HTTP::Post.new(path)
          when :put
            req = Net::HTTP::Put.new(path)
          when :get
            req = Net::HTTP::Get.new(path)
          end
          req.basic_auth(@config.api_user, @config.api_password)
          req.body = data
          req.content_type = "application/xml"

          res = http.request(req)

          case res
          when Net::HTTPSuccess
            return res.body
          else
            puts res.body
            res.error!
          end
        end
      end

      def validate_config(config)
        raise ConfigurationError, 'configuration is nil, did you forget to configure the gem?' unless config
        raise ConfigurationError, 'api_host must be configured' unless string_present? config.api_host
        raise ConfigurationError, 'api_user must be configured' unless string_present? config.api_user
        raise ConfigurationError, 'api_password must be configured' unless string_present? config.api_password
        unless within_range? config.api_port, 1..65535
          raise ConfigurationError, 'api_port must be integer between 1 and 65535' 
        end
      end
    end
  end
end