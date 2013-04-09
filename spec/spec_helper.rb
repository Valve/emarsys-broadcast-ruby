# encoding: UTF-8
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

def create_full_batch
  batch = Emarsys::Broadcast::Batch.new
  batch.name="test_batch_#{Time.now.to_i}"
  batch.subject = 'די שטאַט פון ישראל'
  batch.body_html = '<h1>די שטאט ווערט שוין דערמאנט אין תנ"ך. לויט געוויסע איז אליעזר (עבד אברהם) פון דמשק. דוד המלך, האט מלחמה געהאלטן און איינגענומען דמשק. און שפעטער מלכי ישראל. דאס איז שוין 3,000 יאר צוריק.<i>!</i></h1>'
  batch.sender = 'פייַןבאָכער@gmail.com'
  batch.sender_domain = 'google.com'
  batch.send_time = Time.now + 1000000
  batch
end

def create_minimal_batch
  batch = Emarsys::Broadcast::Batch.new
  batch.name="test_batch_#{Time.now.to_i}"
  batch.subject = 'די שטאַט פון ישראל'
  batch.body_html = '<h1>די שטאט ווערט שוין דערמאנט אין תנ"ך. לויט געוויסע איז אליעזר (עבד אברהם) פון דמשק. דוד המלך, האט מלחמה געהאלטן און איינגענומען דמשק. און שפעטער מלכי ישראל. דאס איז שוין 3,000 יאר צוריק.<i>!</i></h1>'
  batch
end

def spec_time
  Time.new(2013, 12, 31, 0, 0, 0, "-08:00")
end

def spec_sender
  'abc@example.com'
end

