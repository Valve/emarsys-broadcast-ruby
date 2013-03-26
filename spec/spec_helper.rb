require 'coveralls'
Coveralls.wear!

require 'bundler/setup'

require 'emarsys/broadcast'

def restore_default_config
  Emarsys::Broadcast.configuration = nil
  Emarsys::Broadcast.configure {}
end
