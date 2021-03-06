require 'uri'
module Emarsys
  module Broadcast
    class Batch
      include ActiveModel::Validations
      attr_accessor \
        :name,
        :subject,
        :body_html,
        :recipients_path,
        :body_text,
        :send_time,
        :sender,
        :sender_domain,
        :sender_id,
        :import_delay_hours

      validates :name, :subject, :body_html, :recipients_path, :sender, :sender_domain, presence: true
      validates :name, format: { with: /\A[a-z]\w*\z/i, message: 'must start with a letter and contain only letters, numbers and underscores' }
      validates :subject, length: { maximum: 255 }
      validates :sender, format: { with: /@/, message: 'is not a valid email' }
      validates :sender_domain, format: { with: URI::REL_URI, message: 'is not valid' }

      def initialize(attributes = {})
        attributes.each do |name, value|
          send("#{name}=", value)
        end
      end

    end
  end
end
