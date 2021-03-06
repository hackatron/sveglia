Bundler.setup
Bundler.require
require 'sprockets'

require_relative 'actions/hello'
require_relative 'actions/timers_index'
require_relative 'actions/timers_show'
require_relative 'actions/scheduler'
require_relative 'models/redis_record'
require_relative 'models/timer'
require_relative 'lib/goliath/rack/sprockets'

VERSION = "0.1.9".freeze

class SprocketsAPI < Goliath::API
  use Goliath::Rack::Sprockets
end

class Sveglia < Goliath::API
  # map Goliath API to a specific path
  get "/hello", Hello

  # timer resources
  get "/timers", TimersIndex
  # NOTE: https://github.com/postrank-labs/goliath/commit/6cd74b8f4013b7f756e9404fb5f4f8de776b88ac
  get "/timers/:id", TimersShow

  # scheduler test
  get "/scheduler", Scheduler

  get "/assets/*", SprocketsAPI

  # render static files from ./public
  use(Rack::Static,
    :root  => Goliath::Application.app_path("public"),
    :urls  => ['/favicon.ico', '/stylesheets', '/javascripts', '/images', '/notifications.html'],
    :index => '/index.html')

  not_found do
    run Proc.new { |env| [404, {"Content-Type" => "text/html"}, ["Not found"]] }
  end

  # You must use either maps or response, but never both!
  def response(env)
    raise "#response is ignored when using maps, so this exception won't raise. See spec/integration/rack_routes_spec."
  end
end
