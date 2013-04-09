require 'spec_helper'

describe Emarsys::Broadcast::API do
  before(:each){create_valid_config}
  after(:each){restore_default_config}
  let(:config){create_valid_config}
  describe 'initialize' do
    context 'when configured properly' do

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

  describe '#send_batch' do
    let(:api){Emarsys::Broadcast::API.new}
    let(:minimal_batch){create_minimal_batch}

    it 'should raise ValidationError if passed invalid batch' do
      expect {
        invalid_batch = Emarsys::Broadcast::Batch.new
        api.send_batch(invalid_batch)
      }.to raise_error Emarsys::Broadcast::ValidationError
    end
  end
end