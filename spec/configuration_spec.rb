require 'spec_helper'

describe Emarsys::Broadcast::Configuration do

  after(:each){restore_default_config}

  describe 'configure' do

    it 'should return instance of configuration when configured' do
      configuration = Emarsys::Broadcast::configure {}
      expect(configuration).not_to be_nil
      expect(configuration).to be_an_instance_of Emarsys::Broadcast::Configuration
    end


    describe 'when sftp_host is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.sftp_host = 'some_host'
        end
      end

      it 'returns sftp_host' do
        expect(Emarsys::Broadcast.configuration.sftp_host).to eq 'some_host'
      end
    end

    describe 'when sftp_host is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to nil' do
        expect(Emarsys::Broadcast.configuration.sftp_host).to be_nil
      end
    end

    describe 'when sftp_user is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.sftp_user = 'some_user'
        end
      end

      it 'returns sftp_user' do
        expect(Emarsys::Broadcast.configuration.sftp_user).to eq 'some_user'
      end
    end

    describe 'when sftp_user is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to nil' do
        expect(Emarsys::Broadcast.configuration.sftp_user).to be_nil
      end
    end

    describe 'when sftp_password is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.sftp_password = 'some_password'
        end
      end

      it 'returns sftp_password' do
        expect(Emarsys::Broadcast.configuration.sftp_password).to eq 'some_password'
      end
    end

    describe 'when sftp_password is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to nil' do
        expect(Emarsys::Broadcast.configuration.sftp_password).to be_nil
      end
    end

    describe 'when sftp_port is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.sftp_port = 2222
        end
      end

      it 'returns sftp_port' do
        expect(Emarsys::Broadcast.configuration.sftp_port).to eq 2222
      end
    end

    describe 'when sftp_port is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to 22' do
        expect(Emarsys::Broadcast.configuration.sftp_port).to eq 22
      end
    end

    describe 'when http_host is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.http_host = 'some_host'
        end
      end

      it 'returns http_host' do
        expect(Emarsys::Broadcast.configuration.http_host).to eq 'some_host'
      end
    end

    describe 'when http_host is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to e3.emarsys.net' do
        expect(Emarsys::Broadcast.configuration.http_host).to eq 'e3.emarsys.net'
      end
    end

    describe 'when http_user is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.http_user = 'some_user'
        end
      end

      it 'returns http_user' do
        expect(Emarsys::Broadcast.configuration.http_user).to eq 'some_user'
      end
    end

    describe 'when http_user is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to nil' do
        expect(Emarsys::Broadcast.configuration.http_user).to be_nil
      end
    end

    describe 'when http_password is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.http_password = 'some_password'
        end
      end

      it 'returns http_password' do
        expect(Emarsys::Broadcast.configuration.http_password).to eq 'some_password'
      end
    end

    describe 'when http_password is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to nil' do
        expect(Emarsys::Broadcast.configuration.http_password).to be_nil
      end
    end

    describe 'when http_port is set' do
      before do
        Emarsys::Broadcast::configure do |c|
          c.http_port = 8080
        end
      end

      it 'returns http_port' do
        expect(Emarsys::Broadcast.configuration.http_port).to eq 8080
      end
    end

    describe 'when http_port is not set' do
      before do 
        Emarsys::Broadcast::configure {}
      end

      it 'defaults to 80' do
        expect(Emarsys::Broadcast.configuration.http_port).to eq 80
      end
    end
  end

end