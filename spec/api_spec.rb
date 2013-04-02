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

  # describe '#send_batch' do
  #   let(:api){Emarsys::Broadcast::API.new}
  #   let(:batch_builder){Emarsys::Broadcast::BatchXmlBuilder.new(name: 'name', send_time: spec_time, sender: spec_sender)}
  #   before{api.stub(:create_batch_via_api).with(any_args())}

  #   it 'should use config values wnen no explicit options are available' do
  #     Timecop.freeze(spec_time) do
  #       args = {name: 'name', sender: 'abc@example.com', send_time: spec_time}
  #       Emarsys::Broadcast::BatchXmlBuilder.stub(:new => batch_builder)
  #       Emarsys::Broadcast::BatchXmlBuilder.should_receive(:new).with(args)
  #       api.send_batch('name', 'subj', 'body')
  #     end
  #   end

  #   it 'should prefer explicit options over config options when explicits are available' do
  #     new_send_time = spec_time + 30 * 60 # add 30 minutes to spec_time
  #     args = {name: 'name', sender: 'new_sender@example.com', send_time: new_send_time}
  #     Emarsys::Broadcast::BatchXmlBuilder.stub(:new => batch_builder)
  #     Emarsys::Broadcast::BatchXmlBuilder.should_receive(:new).with(args)
  #     api.send_batch('name', 'subj', 'body', sender: 'new_sender@example.com', send_time: new_send_time)
  #   end

  #   it 'should call #create_batch with correct arguments' do
  #     api.should_receive(:create_batch).with('batch_name', 'subject', 'body', nil)
  #     api.send_batch('batch_name', 'subject', 'body')
  #   end

  #   it 'should call #create_batch_via_api with correct arguments' do
  #     batch_builder = Emarsys::Broadcast::BatchXmlBuilder.new(name: 'batch_name', send_time: spec_time, sender: 'abc@example.com')
  #     create_batch_xml = batch_builder.build('subject', 'body')
  #     api.should_receive(:create_batch_via_api).with('batch_name', create_batch_xml)
  #     api.send_batch('batch_name', 'subject', 'body', send_time: spec_time)
  #   end
  # end
end