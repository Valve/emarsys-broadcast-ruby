require 'uri'
module Emarsys
  module Broadcast
    class Batch
      include ActiveModel::Validations
      attr_accessor \
        :name, 
        :subject,
        :body_html,
        :body_text,
        :recipients_path,
        :send_time,
        :sender,
        :sender_domain,
        :sender_id

        validates :name, :subject, :body_html, :recipients_path, :sender, :sender_domain, :sender_id, presence: true
        validates :name, format: {with: /^[^\d\W]\w*\z/i, message: 'must start with a letter and contain only letters, numbers and underscores'}
        validates :subject, length: {maximum: 255}
        validates :sender, format: {with: /@/, message: 'is not a valid email'}
        validates :sender_domain, format: {with: URI::regexp, message: 'is not valid'}

    end
  end
end
