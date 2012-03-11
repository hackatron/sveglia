require 'spec_helper'
require File.join(File.dirname(__FILE__), '..', '..', 'sveglia')

describe Welcome do
  def config_file
    File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'template.rb'))
  end

  let(:api_options) { { :config => config_file } }

  it 'renders haml template with default haml layout' do
    with_api(Welcome, api_options) do
      get_request(:path => '/') do |c|
        c.response.should =~ %r{<title>Sveglia</title>}
      end
    end
  end
end