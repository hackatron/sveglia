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