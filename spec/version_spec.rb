require 'spec_helper'

describe Emarsys::Broadcast::VERSION do
  it 'should return version' do
    expect(Emarsys::Broadcast::VERSION).to_not be_nil
  end
end