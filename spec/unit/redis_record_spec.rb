require 'spec_helper'

describe RedisRecord do
  before(:each) do
    @record = RedisRecord.new(id: 1, name: 'test')
  end

  describe "to_hash" do
    it 'returns an Hash representation of record' do
      @record.to_hash.should == {id: 1, name: 'test'}
    end
  end

  describe "to_json" do
    it 'generates JSON from record.to_hash object' do
      @record.should_receive(:to_hash).and_return(id: 1)
      JSON.should_receive(:generate).with(id: 1).and_return('{"id": 1}')
      @record.to_json.should == '{"id": 1}'
    end

    it 'returns a JSON representation of record' do
      @record.to_json.should == '{"id":1,"name":"test"}'
    end
  end

  describe "generate_token" do
    it 'returns a random string' do
      @record.generate_token.should_not == @record.generate_token
    end

    it 'returns a string 40 characters long' do
      @record.generate_token.size.should == 40
    end
  end

  describe "define_attribute_methods" do
    it 'defines getter methods' do
      @record.respond_to?(:name).should be_true
    end

    it 'defines setter methods' do
      @record.respond_to?(:name=).should be_true
    end
  end

  describe "symbolize_keys" do
    it 'returns an hash with symbolized keys' do
      @record.symbolize_keys!('test' => 'string').should == {:test => 'string'}
    end
  end
end