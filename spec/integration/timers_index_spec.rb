require 'spec_helper'

describe TimersIndex do
  it 'renders a list of timers' do
    with_api(TimersIndex) do
      
      timer = Timer.new(id: 1, name: "test")
      Timer.should_receive(:all).and_return([timer])

      get_request(:path => '/timers') do |c|
        c.response.should == [timer.to_hash]
      end
    end
  end
end