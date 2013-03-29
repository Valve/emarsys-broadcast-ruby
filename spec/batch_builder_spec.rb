require 'spec_helper'

describe Emarsys::Broadcast::BatchBuilder do
  let(:valid_options){options = {name: 'batch_name', send_time: Time.new(2013, 12, 31, 0, 0, 0, "-08:00"), sender: 'test@example.com'}}
  let(:batch_builder){batch_builder = Emarsys::Broadcast::BatchBuilder.new(valid_options)}
  describe 'initialize' do
    context 'with valid options' do

      it 'should create a new instance of BatchBuilder from valid options' do
        expect(batch_builder).not_to be_nil
      end

      it 'should init attributes from required option keys' do
        expect(batch_builder.name).to eq 'batch_name'
        expect(batch_builder.send_time).not_to be_nil
        expect(batch_builder.sender).to eq 'test@example.com'
      end
    end

    context 'with invalid options' do
      it 'should raise ArgumentError when options is nil' do
        expect{Emarsys::Broadcast::BatchBuilder.new(nil)}.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a valid name' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(send_time: Time.now, sender: 'test@example.com')
        }.to raise_error ArgumentError

        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: '', send_time: Time.now, sender: 'test@example.com')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a valid send_time' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'xml_name', sender: 'test@example.com')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a sender' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(send_time: Time.now, name: 'xml_name')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options contains empty sender' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'xml_name', send_time: Time.now, sender: '')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options contains invalid sender email' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: 'xml_name', send_time: Time.now, sender: 'invalid@sender yo')
        }.to raise_error ArgumentError
      end
    end
  end

  describe '#build' do
    context 'with valid arguments' do
      it 'should return a valid Emarsys Xml XML string' do
        actual_xml = batch_builder.build('subject', 'body').chomp
        fixture_path = File.dirname(__FILE__) + '/fixtures/minimal_batch.xml'
        expected_xml = File.read(fixture_path)
        expect(actual_xml).to eq expected_xml
      end

      it 'should properly escape the body of the Emarsys Xml XML string' do
        actual_xml = batch_builder.build('subject', '<h1>hello</h1>').chomp
        fixture_path = File.dirname(__FILE__) + '/fixtures/minimal_escaped_batch.xml'
        expected_xml = File.read(fixture_path)
        expect(actual_xml).to eq expected_xml
      end
    end

    context 'with invalid arguments' do
      it 'should raise ArgumentError when subject is nil' do
        expect {
          batch_builder.build(nil, 'body')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when subject is empty' do
        expect {
          batch_builder.build('', 'body')
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when body is nil' do
        expect {
          batch_builder.build('subject', nil)
        }.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when body is empty' do
        expect {
          batch_builder.build('subject', '')
        }.to raise_error ArgumentError
      end
    end
  end
end