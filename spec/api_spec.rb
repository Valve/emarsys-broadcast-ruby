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

    let(:batch){create_minimal_batch}
    let(:api) do 
      api = Emarsys::Broadcast::API.new
      api.stub(upload_recipients: true) #sftp call
      api
    end
    before{stub_senders_ok_two_senders}
    before{stub_post_ok}


    it 'should raise ValidationError if passed invalid batch' do
      expect {
        invalid_batch = Emarsys::Broadcast::Batch.new
        api.send_batch invalid_batch
      }.to raise_error Emarsys::Broadcast::ValidationError
    end

    it 'should raise ValidationError if such sender does not exist' do
      valid_batch = create_minimal_batch
      valid_batch.sender = 'nonexistent@sender.com'
      expect{
        api.send_batch valid_batch
      }.to raise_error Emarsys::Broadcast::ValidationError
    end

    it 'should post to batch creation Emarsys URL given a valid batch' do
      api.send_batch(batch)
      WebMock.should have_requested(:post, 'https://a:a@e3.emarsys.net/bmapi/v2/batches/batch_name')
    end

    context 'batch supplementation from config' do

      describe 'recipients_path' do
        before(:each)do 
          create_valid_config
          Emarsys::Broadcast.configuration.recipients_path = '/path/from/configuration'
        end
        it 'is in config but not in batch, batch should be updated with recipients_path from config' do
          batch.recipients_path = nil
          api.send_batch batch
          expect(batch.recipients_path).to eq '/path/from/configuration'
        end
        it 'is in config and in batch, batch should not be updated with recipients_path from config' do
          batch.recipients_path = '/path/from/batch'
          api.send_batch batch
          expect(batch.recipients_path).to eq '/path/from/batch'
        end
      end

      describe 'sender' do
        before(:each) do
          create_valid_config
          Emarsys::Broadcast.configuration.sender = 'sender1@example.com'
        end

        it 'is in config but not in batch, batch should be updated with sender from config' do
          batch.sender = nil
          api.send_batch batch
          expect(batch.sender).to eq 'sender1@example.com'
        end

        it 'is in config and in batch, batch should not be updated with sender from config' do
          batch.sender = 'sender2@example.com'
          api.send_batch batch
          expect(batch.sender).to eq 'sender2@example.com'
        end
      end

      describe 'sender_domain' do
        before(:each) do
          create_valid_config
          Emarsys::Broadcast.configuration.sender_domain = 'configuration.com'
        end

        it 'is in config but not in batch, batch should be updated with sender_domain from config' do
          batch.sender_domain = nil
          api.send_batch batch
          expect(batch.sender_domain).to eq 'configuration.com'
        end

        it 'is in config and in batch, batch should not be updated with sender_domain from config' do
          batch.sender_domain = 'batch.com'
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
          batch.import_delay_hours = nil
          api.send_batch batch
          expect(batch.import_delay_hours).to eq 23
        end

        it 'is in config and in batch, batch should not be updated with import_delay_hours from config' do
          batch.import_delay_hours = 17
          api.send_batch batch
          expect(batch.import_delay_hours).to eq 17
        end
      end

      describe 'send_time' do
        it 'is not in batch, batch should be scheduled for current time' do
          Timecop.freeze(spec_time) do
            batch.send_time = nil
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