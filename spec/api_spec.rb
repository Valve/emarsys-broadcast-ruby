require 'spec_helper'

describe Emarsys::Broadcast::API do
  after(:each){restore_default_config}
  describe 'initialize' do
    context 'when configured properly' do
      let(:config) do
      end
      it 'should initialize a new instance of API' do
        api = Emarsys::Broadcast::API.new
        expect(api).not_to be_nil
      end

    end
  end
end