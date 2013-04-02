module Emarsys
  module Broadcast
    class Batch
      attr_accessor \
        :name, 
        :subject,
        :body,
        :recipients_path,
        :send_time,
        :sender,
        :sender_domain,
        :sender_id

    end
  end
end
