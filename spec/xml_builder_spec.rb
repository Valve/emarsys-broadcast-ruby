require 'spec_helper'
describe Emarsys::Broadcast::XmlBuilder do
  let(:valid_options){options = {name: 'batch_name'}}
  let(:xml_builder){Emarsys::Broadcast::XmlBuilder.new(valid_options)}
  describe 'initialize' do
    context 'with valid options' do

      it 'should create a new instance of XmlBuilder from valid options' do
        expect(xml_builder).not_to be_nil
      end

      it 'should init attributes from required option keys' do
        expect(xml_builder.name).to eq 'batch_name'
      end
    end

    context 'with invalid options' do
      it 'should raise ArgumentError when options is nil' do
        expect{Emarsys::Broadcast::XmlBuilder.new(nil)}.to raise_error ArgumentError
      end

      it 'should raise ArgumentError when options does not contain a valid name' do
        expect{
          Emarsys::Broadcast::BatchBuilder.new({})
        }.to raise_error ArgumentError

        expect{
          Emarsys::Broadcast::BatchBuilder.new(name: '')
        }.to raise_error ArgumentError
      end
    end
  end
end