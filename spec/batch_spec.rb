require 'spec_helper'

describe Emarsys::Broadcast::Batch do
  it 'should initialize a new instance of batch' do
    expect(Emarsys::Broadcast::Batch.new).not_to be_nil
  end
end