# Emarsys::Broadcast

Ruby wrapper for Emarsys batch mailing API
==========================================
[![Build Status](https://travis-ci.org/Valve/emarsys-broadcast-ruby.png)](https://travis-ci.org/Valve/emarsys-broadcast-ruby)
[![Code Climate](https://codeclimate.com/github/Valve/emarsys-broadcast-ruby.png)](https://codeclimate.com/github/Valve/emarsys-broadcast-ruby)

## Installation

Add this line to your application's Gemfile:

    gem 'emarsys-broadcast'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install emarsys-broadcast

## Usage

### Complete sending example:

Minimal configuration is required before usage

```ruby
# if using rails, place this configuration code into initializer
Emarsys::Broadcast::configure do |c|
  c.api_user = your_api_user
  c.api_password = your_api_password

  c.sftp_user = your_sftp_user
  c.sftp_password = your_sftp_password

  c.sender_domain = 'mail.your.company.com'
end


# create a batch that you want to send
batch = Emarsys::Broadcast::Batch.new
batch.sender = 'sender_id'
batch.name = 'newsletter_2013_06_01'
batch.subject = 'June 2013 company news'
batch.body_html = '<h1>Dear 朋友!</h1>'
batch.recipients_path = '/path/to/your/csv/with/emails'

# create API client
api = Emarsys::Broadcast::API.new

# now send your batch
api.send_batch(batch)
```

This will synchronously send the batch email to all recipients found in CSV file.

### Moving batch properties to configuration

If you find yourself using same batch attributs over and over again, for example `recipients_path`, 
you can move those values into configuration:

```ruby
Emarsys::Broadcast::configure do |c|
  c.api_user = your_api_user
  c.api_password = your_api_password

  c.sftp_user = your_sftp_user
  c.sftp_password = your_sftp_password

  c.sender = 'sender_id'
  c.sender_domain = 'mail.your.company.com'
  c.recipients_path = '/path/to/hyour/csv/with/emails'
end

# now you can omit these attributes when constructing a batch:
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_06_01'
batch.subject = 'June 2013 company news'
batch.body_html = '<h1>Dear 朋友!</h1>'

# send your batch as above, via api
```


### Creating batch from hash

If you like, you can construct your batch from a hash, like follows:

```ruby
batch = Emarsys::Broadcast::Batch.new name: 'name', subject: 'subject', body_html: '<h1>html body</h1>'
```

### Batch name requirements

Batch name must be a valid identifier, i.e. start with a letter and contain letters, digits and underscores
Emarsys requires every batch have a unique name, but you don't have to maintain the uniqueness, because
this library internally appends a timestamp to each batch name before submitting it to Emarsys

### Batch subject requirements

Batch subject must be a string with a maximum length of 255 characters

### Batch body html 

Batch body html can be any HTML text, no restrictions

### Batch body in plain text

It is possible to supply the body contents in plain text, this will broaden compatibility, 
because some email clients don't support HTML and will download textual version instead.

```ruby
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_06_01'
batch.subject = 'June 2013 company news'
batch.body_html = '<h1>Dear 朋友!</h1>'
batch.body_text = 'Dear 朋友'
```

### Batch validation

Emarsys::Broadcast uses ActiveModel for validating plain ruby objects, so you have all the methods for 
validation you're accustomed to:

```ruby
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_06_01'

batch.valid? # false
batch.errors 
batch.errors.full_messages
```

You can always validate your batch before submitting it.

Note that calling api#send_batch on an invalid batch will throw ValidationException

```ruby

batch = get_invalid_batch
api = Emarsys::Broadcast::API.new
begin
  api.send_batch batch
rescue Emarsys::Broadcast::ValidationException => ex
  # get exception message
  puts ex.message

  # get exception errors (ActiveModel compatible)
  puts ex.errors
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run specs (`rspec`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request


## License


Copyright (c) 2013 Valentin Vasilyev

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
