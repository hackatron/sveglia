class TimersIndex < Goliath::API
  # parse query params and auto format JSON response
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  def response(env)
    resp = Timer.all

    [200, {'Content-Type' => 'application/json'}, resp]
  end
end