require 'spec_helper'

describe Timer do
  before(:each) do
    @timer = Timer.new(id: 1, name: 'test')
  end

  describe "self.all" do
    it 'returns an array of 100 elements' do
      Timer.all.count.should == 100
    end
  end

  describe "self.find" do
    it 'returns a timer' do
      Timer.find(1).id.should == @timer.id
    end
  end

  describe "to_hash" do
    it 'returns an Hash representation of timer' do
      @timer.to_hash.should == {'id' => 1, 'name' => 'test'}
    end
  end

  describe "to_json" do
    it 'generates JSON from timer.to_hash object' do
      @timer.should_receive(:to_hash).and_return({'id' => 1})
      JSON.should_receive(:generate).with({'id' => 1}).and_return('{"id": 1}')
      @timer.to_json.should == '{"id": 1}'
    end

    it 'returns a JSON representation of timer' do
      @timer.to_json.should == '{"id":1,"name":"test"}'
    end
  end
end