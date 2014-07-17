require 'net/sftp'
require 'spec_helper'

describe Emarsys::Broadcast::SFTP do

  describe 'initialize' do
    after(:each){restore_default_config}
    it 'should create a new instance of SFTP from valid configuration' do
      config = Emarsys::Broadcast::configure do |c|
        c.sftp_host = 'localhost'
        c.sftp_user = 'user'
        c.sftp_password = 'password'
      end

      sftp = Emarsys::Broadcast::SFTP.new config
      expect(sftp).not_to be_nil
    end

    context 'invalid sftp configuration' do
      it 'should raise ConfigurationError when config is nil (was never configured)' do
        expect{Emarsys::Broadcast::SFTP.new(nil)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when no sftp_user is configured' do
        config = Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'host'
          c.sftp_password = 'password'
        end
        expect{Emarsys::Broadcast::SFTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when no sftp_password is configured' do
        config = Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'host'
          c.sftp_user = 'user'
        end
        expect{Emarsys::Broadcast::SFTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when sftp_port is nil' do
        config = Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'host'
          c.sftp_user = 'user'
          c.sftp_password = 'password'
          c.sftp_port = nil
        end
        expect{Emarsys::Broadcast::SFTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when sftp_port is not Integer' do
        config = Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'host'
          c.sftp_user = 'user'
          c.sftp_password = 'password'
          c.sftp_port = 'blaster'
        end
        expect{Emarsys::Broadcast::SFTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end

      it 'should raise ConfigurationError when  sftp_port is outside the valid range (1..65536)' do
        config = Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'host'
          c.sftp_user = 'user'
          c.sftp_password = 'password'
          c.sftp_port = 999999
        end
        expect{Emarsys::Broadcast::SFTP.new(config)}.to raise_error Emarsys::Broadcast::ConfigurationError
      end
    end
  end

  context 'initialized' do
    let(:config) do
      config = Emarsys::Broadcast::configure do |c|
        c.sftp_host = 'host'
        c.sftp_user = 'user'
        c.sftp_password = 'password'
      end
    end

    let(:sftp) do
      Emarsys::Broadcast::SFTP.new config
    end

    describe '#upload_file' do
      it 'should call Net::SFTP.start with sftp configuration values' do
        expect(Net::SFTP).to receive(:start).with(config.sftp_host, config.sftp_user, password: config.sftp_password)
        sftp.upload_file('local_file', 'remote_file')
      end

      it 'should take an instance of SFTP as a block argument and call #upload! on it with file paths' do
        mock_session = double('session')
        allow(Net::SFTP).to receive(:start).and_yield mock_session
        expect(mock_session).to receive(:upload!).with('local_file', 'remote_file')
        sftp.upload_file('local_file', 'remote_file')
      end
    end
  end
end