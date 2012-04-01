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
end