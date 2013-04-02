require 'spec_helper'

describe Emarsys::Broadcast::HTTP do
  let(:config){create_valid_config}
  let(:http){Emarsys::Broadcast::HTTP.new config}

  # describe 'initialize' do
  #   after(:each){restore_default_config}
  #   it 'should create a new instance of HTTP from valid configuration' do
  #     expect(http).not_to be_nil
  #   end

  #   it 'should instantiate a new instance of HttpClient' do
  #     HTTPClient.should_receive(:new)
  #     Emarsys::Broadcast::HTTP.new config
  #   end


  #   context 'invalid http configuration' do
      
  #     it 'should raise ConfigurationError when config is nil (was never configured)' do
  #       expect{Emarsys::Broadcast::SFTP.new(nil)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end

  #     it 'should raise ConfigurationError when no api_user is configured' do
  #       config = Emarsys::Broadcast::configure do |c|
  #         c.api_host = 'host'
  #         c.api_password = 'password'
  #       end
  #       expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end

  #     it 'should raise ConfigurationError when no api_password is configured' do
  #       config = Emarsys::Broadcast::configure do |c|
  #         c.api_host = 'host'
  #         c.api_user = 'user'
  #       end
  #       expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end

  #     it 'should raise ConfigurationError when api_port is nil' do
  #       config = Emarsys::Broadcast::configure do |c|
  #         c.api_host = 'host'
  #         c.api_user = 'user'
  #         c.api_password = 'password'
  #         c.api_port = nil
  #       end
  #       expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end

  #     it 'should raise ConfigurationError when api_port is not Integer' do
  #       config = Emarsys::Broadcast::configure do |c|
  #         c.api_host = 'host'
  #         c.api_user = 'user'
  #         c.api_password = 'password'
  #         c.api_port = 'blaster'
  #       end
  #       expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end

  #     it 'should raise ConfigurationError when  api_port is outside the valid range (1..65536)' do
  #       config = Emarsys::Broadcast::configure do |c|
  #         c.api_host = 'host'
  #         c.api_user = 'user'
  #         c.api_password = 'password'
  #         c.api_port = 999999
  #       end
  #       expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
  #     end
  #   end
  # end

  # describe '#post' do

  #   context 'invalid arguments' do

  #     it 'should raise ArgumentError if url is nil' do
  #       expect {
  #         http.post(nil, '<xml/>')
  #       }.to raise_error ArgumentError
  #     end

  #     it 'should raise ArgumentError if url is empty' do
  #       expect {
  #         http.post('', '<xml/>')
  #       }.to raise_error ArgumentError
  #     end

  #     it 'should raise ArgumentError if url is all spaces' do
  #       expect {
  #         http.post('  ', '<xml/>')
  #       }.to raise_error ArgumentError
  #     end

  #     it 'should raise ArgumentError if xml is nil' do
  #       expect {
  #         http.post('/path', nil)
  #       }.to raise_error ArgumentError
  #     end

  #     it 'should raise ArgumentError if xml is empty' do
  #       expect {
  #         http.post('/path', '')
  #       }.to raise_error ArgumentError
  #     end

  #     it 'should raise ArgumentError if xml is all spaces' do
  #       expect {
  #         http.post('/path', '    ')
  #       }.to raise_error ArgumentError
  #     end
  #   end

  #   context 'valid arguments' do
  #     it 'should call HTTPClient#post with valid arguments' do
  #       path = 'path'
  #       xml = '<xml/>'
  #       url = config.api_host + path
  #       client = http.instance_variable_get(:@client)
  #       client.should_receive(:set_basic_auth).with(url, config.api_user, config.api_password)
  #       client.should_receive(:post).with(url, xml, 'Content-Type' => 'application/xml')
  #       http.post(path, xml)
  #     end
  #   end
  # end
end