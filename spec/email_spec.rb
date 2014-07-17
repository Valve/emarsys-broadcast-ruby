require 'spec_helper'

describe Emarsys::Broadcast::Email do
  it 'should validate valid email' do
    expect(Emarsys::Broadcast::Email::validate 'winston.smith-1984@big.brother.ru').to be_truthy
    expect(Emarsys::Broadcast::Email::validate 'abc@example.com').to be_truthy
  end
  it 'should not validate invalid email' do
    expect(Emarsys::Broadcast::Email::validate 'some invalid@email').to be_falsey
  end
end