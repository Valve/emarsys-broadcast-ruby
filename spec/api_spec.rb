require 'spec_helper'

describe Emarsys::Broadcast::API do
  before(:each){create_valid_config}
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
    let(:empty_batch){Emarsys::Broadcast::Batch.new}
    it 'should raise ValidationError if passed invalid batch' do
      expect {
        invalid_batch = Emarsys::Broadcast::Batch.new
        api.send_batch empty_batch
      }.to raise_error Emarsys::Broadcast::ValidationError
    end

    context 'batch supplementation from config' do
      let(:api) do
        api = Emarsys::Broadcast::API.new
        api.stub(validate_batch: true, validate_sender: true, create_batch: true, upload_recipients: true, 
          trigger_import: true)
        api
      end
      let(:batch){Emarsys::Broadcast::Batch.new}
      describe 'recipients_path' do
        before(:each)do 
          create_valid_config
          Emarsys::Broadcast.configuration.recipients_path = '/path/from/configuration'
        end
        it 'is in config but not in batch, batch should be updated with recipients_path from config' do
          api.send_batch batch
          expect(batch.recipients_path).to eq '/path/from/configuration'
        end
        it 'is in config and in batch, batch should not be updated with recipients_path from config' do
          batch = Emarsys::Broadcast::Batch.new(recipients_path: '/path/from/batch')
          api.send_batch batch
          expect(batch.recipients_path).to eq '/path/from/batch'
        end
      end

      describe 'sender' do
        before(:each) do
          create_valid_config
          Emarsys::Broadcast.configuration.sender = 'sender@configuration.com'
        end

        it 'is in config but not in batch, batch should be updated with sender from config' do
          api.send_batch batch
          expect(batch.sender).to eq 'sender@configuration.com'
        end

        it 'is in config and in batch, batch should not be updated with sender from config' do
          batch = Emarsys::Broadcast::Batch.new(sender: 'sender@batch.com')
          api.send_batch batch
          expect(batch.sender).to eq 'sender@batch.com'
        end
      end

      describe 'sender_domain' do
        before(:each) do
          create_valid_config
          Emarsys::Broadcast.configuration.sender_domain = 'configuration.com'
        end

        it 'is in config but not in batch, batch should be updated with sender_domain from config' do
          api.send_batch batch
          expect(batch.sender_domain).to eq 'configuration.com'
        end

        it 'is in config and in batch, batch should not be updated with sender_domain from config' do
          batch = Emarsys::Broadcast::Batch.new(sender_domain: 'batch.com')
          api.send_batch batch
          expect(batch.sender_domain).to eq 'batch.com'
        end
      end

      describe 'import_delay_hours' do
        before(:each) do
          create_valid_config
          Emarsys::Broadcast.configuration.import_delay_hours  = 23
        end

        it 'is in config but not in batch, batch should be updated with import_delay_hours from config' do
          api.send_batch batch
          expect(batch.import_delay_hours).to eq 23
        end

        it 'is in config and in batch, batch should not be updated with import_delay_hours from config' do
          batch = Emarsys::Broadcast::Batch.new(import_delay_hours: 17)
          api.send_batch batch
          expect(batch.import_delay_hours).to eq 17
        end
      end

      describe 'send_time' do
        it 'is not in batch, batch should be scheduled for current time' do
          Timecop.freeze(spec_time) do
            api.send_batch batch
            expect(batch.send_time).to eq spec_time
          end
        end

        it 'is set in batch, batch should not be scheduled for current time' do
          Timecop.freeze(spec_time) do
            batch.send_time = Time.now + 30_000
            api.send_batch batch
            expect(batch.send_time).not_to eq spec_time
          end
        end
      end
    end
  end
end