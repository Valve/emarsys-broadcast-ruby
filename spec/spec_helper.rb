require 'bundler/setup'
require 'emarsys/broadcast'

def restore_default_config
  Emarsys::Broadcast.configuration = nil
  Emarsys::Broadcast.configure {}
end

def create_valid_config
  Emarsys::Broadcast::configure do |c|
    c.sftp_host = 'a'
    c.sftp_user = 'a'
    c.sftp_password = 'a'

    c.http_host = 'a'
    c.http_user = 'a'
    c.http_password = 'a'
  end
end
