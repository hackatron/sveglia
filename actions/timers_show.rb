class TimersShow < Goliath::API
  # parse query params and auto format JSON response
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  def response(env)
    @timer = Timer.find(params[:id])

    [200, {'Content-Type' => 'application/json'}, @timer]
  end
end