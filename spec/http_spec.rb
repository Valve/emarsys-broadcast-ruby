require 'spec_helper'

describe Emarsys::Broadcast::HTTP do
  let(:config){create_valid_config}
  let(:http){Emarsys::Broadcast::HTTP.new config}
end