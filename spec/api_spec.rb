require 'spec_helper'

describe Emarsys::Broadcast::API do
  after(:each){restore_default_config}
  describe 'initialize' do
    context 'when configured properly' do
      let(:config){create_valid_config}
      before(:each){create_valid_config}

      it 'should initialize a new instance of API' do
        api = Emarsys::Broadcast::API.new
        expect(api).not_to be_nil
      end

      it 'should instantiate sftp' do
        Emarsys::Broadcast::SFTP.should_receive(:new).with(config)
        api = Emarsys::Broadcast::API.new
      end

      it 'should instantiate http' do
        Emarsys::Broadcast::HTTP.should_receive(:new).with(config)
        api = Emarsys::Broadcast::API.new
      end
    end
  end
end