require 'spec_helper'
describe Emarsys::Broadcast::XmlBuilder do
  let(:valid_options){options = {name: 'batch_name'}}
  let(:xml_builder){Emarsys::Broadcast::XmlBuilder.new(valid_options)}
end