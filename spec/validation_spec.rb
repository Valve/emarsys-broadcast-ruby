require 'spec_helper'

describe Emarsys::Broadcast::Validation do 
  class Test
    include Emarsys::Broadcast::Validation
  end
  let(:test){Test.new}
  describe '#string_present?' do

    it 'should return true if string not nil or empty' do
      expect(test.string_present? 'hello').to be_truthy
    end

    it 'should return false if string is nil' do
      expect(test.string_present? nil).to be_falsey
    end

    it 'should return false if string is empty' do
      expect(test.string_present? '').to be_falsey
    end

    it 'should return false if string is all spaces' do
      expect(test.string_present? '   ').to be_falsey
    end
  end

  describe '#within_range?' do
    it 'should return true if integer is within range' do
      expect(test.within_range? 99, 1..100).to be_truthy
    end

    it 'should return false if integer is not within range' do
      expect(test.within_range? 101, 1..100).to be_falsey
    end

    it 'should return false if integer is nil' do
      expect(test.within_range? nil, 1..100).to be_falsey
    end

    it 'should raise ArgumentError is range is nil' do
      expect{test.within_range?(99, nil)}.to raise_error ArgumentError
    end

    it 'should raise ArgumentError is range is not a Range' do
      expect{test.within_range?(99, [])}.to raise_error ArgumentError
    end
  end
  
end
