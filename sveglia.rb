require 'goliath'
require 'goliath/rack/templates'
require 'goliath/plugins/latency'
require 'em-synchrony/em-http'
require 'em-http/middleware/json_response'
require 'yajl'
require 'json'

require_relative 'actions/hello'
require_relative 'actions/timers_index'
require_relative 'actions/scheduler'
require_relative 'models/timer'

VERSION = "0.1.5".freeze

# automatically parse the JSON HTTP response
EM::HttpRequest.use EventMachine::Middleware::JSONResponse

class Sveglia < Goliath::API
  # map Goliath API to a specific path
  get "/hello", Hello

  # timer resources
  get "/timers", TimersIndex

  # scheduler test
  get "/scheduler", Scheduler
  
  # render static files from ./public
  use(Rack::Static,
    :root  => Goliath::Application.app_path("public"),
    :urls  => ['/favicon.ico', '/stylesheets', '/javascripts', '/images'],
    :index => '/index.html')

  not_found do
    run Proc.new { |env| [404, {"Content-Type" => "text/html"}, ["Not found"]] }
  end

  # You must use either maps or response, but never both!
  def response(env)
    raise "#response is ignored when using maps, so this exception won't raise. See spec/integration/rack_routes_spec."
  end
end
