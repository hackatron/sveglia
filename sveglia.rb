require 'goliath'
require 'goliath/rack/templates'
require 'goliath/plugins/latency'
require 'em-synchrony/em-http'
require 'em-http/middleware/json_response'
require 'yajl'
require 'tilt'
require 'haml'

class Template < Goliath::API
  include Goliath::Rack::Templates      # render templated files from ./views
  plugin Goliath::Plugin::Latency       # ask eventmachine reactor to track its latency

  def recent_latency
    Goliath::Plugin::Latency.recent_latency
  end

  def response(env)
    [200, {}, haml(:index)]
  end
end

# automatically parse the JSON HTTP response
EM::HttpRequest.use EventMachine::Middleware::JSONResponse

class Hello < Goliath::API
  # parse query params and auto format JSON response
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  def response(env)
    resp = nil

    if params['query']
      # simple GitHub API proxy example
      logger.info "Starting request for #{params['query']}"
      conn = EM::HttpRequest.new("http://github.com/api/v2/json/repos/search/#{params['query']}").get
      logger.info "Received #{conn.response_header.status} from Github"
      resp = conn.response
    else
      resp = env # output the Goalith environment
    end

    [200, {'Content-Type' => 'application/json'}, resp]
  end
end

class RackRoutes < Goliath::API
  # map Goliath API to a specific path
  get "/", Template
  get "/hello", Hello
  
  use(Rack::Static,                     # render static files from ./public
      :root => Goliath::Application.app_path("public"),
      :urls => ["/favicon.ico", '/stylesheets', '/javascripts', '/images'])

  not_found do
    run Proc.new { |env| [404, {"Content-Type" => "text/html"}, ["Try /version /hello_world, /bonjour, or /hola"]] }
  end

  # You must use either maps or response, but never both!
  def response(env)
    raise "#response is ignored when using maps, so this exception won't raise. See spec/integration/rack_routes_spec."
  end
end