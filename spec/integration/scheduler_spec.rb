require 'spec_helper'

describe Scheduler do
  it 'renders default delay time' do
    with_api(Scheduler) do
      get_request(path: '/scheduler') do |c|
        c.response['delay'].should == 1
      end
    end
  end

  it 'renders delay time from params' do
    with_api(Scheduler) do
      get_request(path: '/scheduler', query: {delay: 0.5}) do |c|
        c.response['delay'].should == "0.5"
      end
    end
  end
end