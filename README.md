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

### Minimal configuration is required before usage

```ruby
# if using rails, place this configuration code into initializer
Emarsys::Broadcast::configure do |c|
  c.api_user = your_api_user
  c.api_password = your_api_password

  c.sftp_user = your_sftp_user
  c.sftp_password = your_sftp_password
end


# create a batch that you want to send
batch = Emarsys::Broadcast::Batch.new
batch.name = 'newsletter_2013_05_01'
batch.subject = 'May 2013 company news'
batch.body_html = '<h1>Dear friends!</h1>'
batch.recipients_path = /path/to/your/csv/with/emails

# create API client
api = Emarsys::Broadcast::API.new

# now send your batch
api.send_batch(batch)
```

This will synchronously send the batch email to all recipients found in CSV file.


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
