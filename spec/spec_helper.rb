require 'bundler/setup'
require 'emarsys/broadcast'
require 'timecop'


def restore_default_config
  Emarsys::Broadcast.configuration = nil
  Emarsys::Broadcast.configure {}
end

def create_valid_config
  Emarsys::Broadcast::configure do |c|
    c.sftp_host = 'a'
    c.sftp_user = 'a'
    c.sftp_password = 'a'

    c.api_user = 'a'
    c.api_password = 'a'

    c.sender = spec_sender
  end
end

def spec_time
  Time.new(2013, 12, 31, 0, 0, 0, "-08:00")
end

def spec_sender
  'abc@example.com'
end

