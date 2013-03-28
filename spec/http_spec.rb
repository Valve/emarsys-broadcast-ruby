require 'spec_helper'
require 'httpclient'

describe Emarsys::Broadcast::HTTP do

  describe 'initialize' do
    after(:each){restore_default_config}
    it 'should create a new instance of HTTP from valid configuration' do
      config = Emarsys::Broadcast::configure do |c|
        c.http_host = 'localhost'
        c.http_user = 'user'
        c.http_password = 'password'
      end

      http = Emarsys::Broadcast::HTTP.new config
      expect(http).not_to be_nil
    end

    context 'invalid http configuration' do

      it 'should raise ConfigurationError when no http_user is configured' do
        config = Emarsys::Broadcast::configure do |c|
          c.http_host = 'host'
          c.http_password = 'password'
        end
        expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when no http_password is configured' do
        config = Emarsys::Broadcast::configure do |c|
          c.http_host = 'host'
          c.http_user = 'user'
        end
        expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when http_port is nil' do
        config = Emarsys::Broadcast::configure do |c|
          c.http_host = 'host'
          c.http_user = 'user'
          c.http_password = 'password'
          c.http_port = nil
        end
        expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when http_port is not Integer' do
        config = Emarsys::Broadcast::configure do |c|
          c.http_host = 'host'
          c.http_user = 'user'
          c.http_password = 'password'
          c.http_port = 'blaster'
        end
        expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when  http_port is outside the valid range (1..65536)' do
        config = Emarsys::Broadcast::configure do |c|
          c.http_host = 'host'
          c.http_user = 'user'
          c.http_password = 'password'
          c.http_port = 999999
        end
        expect{Emarsys::Broadcast::HTTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end
    end
  end

  # context 'initialized' do
  #   let(:config) do
  #     config = Emarsys::Broadcast::configure do |c|
  #       c.http_host = 'host'
  #       c.http_user = 'user'
  #       c.http_password = 'password'
  #     end
  #   end

  #   let(:http) do
  #     Emarsys::Broadcast::HTTP.new config
  #   end

  #   describe '#upload_file' do
  #     it 'should call Net::HTTP.start with http configuration values' do
  #       Net::HTTP.should_receive(:start).with(config.http_host, config.http_user, password: config.http_password)
  #       http.upload_file('local_file', 'remote_file')
  #     end

  #     it 'should take an instance of HTTP as a block argument and call #upload! on it with file paths' do
  #       mock_session = mock('session')
  #       Net::HTTP.stub(:start).and_yield mock_session
  #       mock_session.should_receive(:upload!).with('local_file', 'remote_file')
  #       http.upload_file('local_file', 'remote_file')
  #     end
  #   end
  # end
end