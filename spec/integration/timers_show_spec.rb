require 'spec_helper'

describe TimersShow do
  it 'renders a timer' do
    with_api(TimersShow) do
      
      timer = Timer.new(id: 1, name: "test")
      Timer.should_receive(:find).with('1').and_return(timer)

      get_request(:path => '/timers', :query => {:id => 1}) do |c|
        c.response.should == timer.to_hash
      end
    end
  end
end