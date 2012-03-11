class Welcome < Goliath::API
  include Goliath::Rack::Templates      # render templated files from ./views
  plugin Goliath::Plugin::Latency       # ask eventmachine reactor to track its latency

  def recent_latency
    Goliath::Plugin::Latency.recent_latency
  end

  def response(env)
    [200, {}, haml(:index, :locals => {:title => "Sveglia"})]
  end
end