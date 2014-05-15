# Emarsys::Broadcast a ruby wrapper for Emarsys batch mailing API

[![Build Status](https://travis-ci.org/Valve/emarsys-broadcast-ruby.svg)](https://travis-ci.org/Valve/emarsys-broadcast-ruby)
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
batch.sender = 'news@company.com'
batch.name = 'newsletter_2013_06_01'
batch.subject = 'June 2013 company news'
batch.body_html = '<h1>Dear 朋友!</h1>'
batch.recipients_path = '/path/to/your/csv/with/emails.csv'

# create API client
api = Emarsys::Broadcast::API.new

# now send your batch
api.send_batch(batch)
```

This will synchronously send the batch email to all recipients found in CSV file.

### Creating batch from hash

If you like, you can construct your batch from a hash, like follows:

```ruby
batch = Emarsys::Broadcast::Batch.new name: 'name', subject: 'subject', body_html: '<h1>html body</h1>'
```

### Required batch attributes

#### Batch#name

Batch name must be a valid identifier, i.e. start with a letter and contain letters, digits and underscores.
Emarsys requires every batch to have a unique name, but you don't have to maintain the uniqueness, because
this library internally appends a timestamp to each batch name before submitting it to Emarsys.

#### Batch#subject

Batch subject must be a string with a maximum length of 255 characters

#### Batch#sender

Valid email, registed with Emarsys.

Emarsys maintains a list of allowed sender emails, and restricts
sending emails from arbitrary email. If you want to use an email as a 
sender, refer to  [working with senders](#working-with-senders)

_Can be set once via configuration_

#### Batch#body_html 

Batch body html can be any HTML text, no restrictions

#### Batch#recipients_path

Absolute path to CSV file with recipients data.

_Can be set once via configuration_

### Optional batch attributes

#### Batch#body_text

It is possible to supply the body contents in plain text, this will broaden compatibility, 
because some email clients don't support HTML and will download textual version instead.

```ruby
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_06_01'
batch.subject = 'June 2013 company news'
batch.body_html = '<h1>Dear 朋友!</h1>'
batch.body_text = 'Dear 朋友'
```

#### Batch#send_time

You can set the batch send time using this optional attribute. If you don't set it
it will be scheduled for immediate sending.


#### Batch.import_delay_hours

Time in hours which is allowed for import to be delayed after batch import. Defaults to 1 hour.

_Can be set once via configuration_


### Moving batch properties to configuration

If you find yourself using same batch attributes over and over again,
you can move these attributes into configuration:

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

#### List of configurable attributes
* sender (required attribute)
* sender_domain (required attribute)
* recipients_path (required attribute)
* import_delay_hours (optional attribute) see more [here](#batchimport_delay_hours)


### Batch validation

`Emarsys::Broadcast` uses `ActiveModel` for validating plain ruby objects, so you have all the methods for 
validation you're accustomed to:

```ruby
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_06_01'

batch.valid? # false
batch.errors 
batch.errors.full_messages
```

You can always validate your batch before submitting it.

Note that calling `API#send_batch` on an invalid batch will throw `ValidationException`

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

### Scheduling batches

By default a new batch is scheduled for immediate sending, but you can set the `Batch#send_time`

```ruby
# Assuming using ActiveSupport and want to schedule a batch to be sent in 10 days
batch.send_time = Time.zone.now + 10.days
# .. more attributes

api.send_batch batch
```

### CSV file requirements

The recipients must be placed in a `UTF-8` CSV file.
The file must have at least one column with `EMAIL` header, for example:

```csv
EMAIL
john.doe@gmail.com
sara.parker@yahoo.com
...
...
```

If you use additional customization columns, add them to your CSV file:

```csv
EMAIL FIRST_NAME
john.doe@gmail.com John
sara.parker@yahoo.com Sara
...
...
```
Having additional columns allows you to customize your body_html, for example:

```html
<h1>Hi, $$FIRST_NAME$$</h1>
```

### Working with senders

#### Adding a new sender

Adding a sender is required before you can start using its email address as a `Batch#sender`

```ruby 
# assuming you have API configured already
api = Emarsys::Broadcast::API.new
# sender requires 3 arguments: id, name, email_address
sender = Emarsys::Broadcast::Sender.new('primary_newsletter_sender', 'My company', 'news@company.com')
api.create_sender sender
```

Once you add a sender, you can use its email in any batch:

```ruby
batch.sender = 'news@company.com'
# more attributes
```

#### Getting a full list of senders

```ruby
api.get_senders 
# returns array of `Emarsys::Broadcast::Sender`
```

#### Getting a single sender by email

```ruby 
api.get_sender('news@mycompany.ru')
```

#### Finding if a sender exists by email

```ruby
api.sender_exists? 'news@mycompany.ru'
```


### Compatibility

This gem is tested on
* MRI `1.9.2`, `1.9.3`, `2.0.0`
* JRuby 1.9 mode


### Further plans

This library does not yet cover all Emarsys functionality, so the plans are to cover 100% of Emarsys features,
add async support, more scheduling options etc. 

If you want to help me with this, pull requests are especially welcome :)


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
