require 'spec_helper'

describe Emarsys::Broadcast::Batch do
  it 'should initialize a new instance of batch' do
    expect(Emarsys::Broadcast::Batch.new).not_to be_nil
  end
  
  # it 'should raise ArgumentError if name is nil' do
  #   expect{
  #     api.send_batch(nil, 'subject', 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if name is empty' do
  #   expect{
  #     api.send_batch('', 'subject', 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if name is all spaces' do
  #   expect{
  #     api.send_batch('  ', 'subject', 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if subject is nil' do
  #   expect{
  #     api.send_batch('name', nil, 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if subject is empty' do
  #   expect{
  #     api.send_batch('name', '', 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if subject is all spaces' do
  #   expect{
  #     api.send_batch('name', '  ', 'body')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if body is nil' do
  #   expect{
  #     api.send_batch('name', 'subj', nil)
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if body is empty' do
  #   expect{
  #     api.send_batch('name', 'subj', '')
  #   }.to raise_error ArgumentError
  # end

  # it 'should raise ArgumentError if body is all spaces' do
  #   expect{
  #     api.send_batch('name', 'subj', '    ')
  #   }.to raise_error ArgumentError
  # end

end