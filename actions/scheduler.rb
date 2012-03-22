class Scheduler < Goliath::API
  # parse query params and auto format JSON response
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  def response(env)
    delay = params['delay'] || 1

    f = Fiber.current
    EventMachine.add_timer delay, proc { f.resume }
    Fiber.yield

    [200, {'Content-Type' => 'application/json'}, {delay: delay, request_time: (Time.now.to_f - env[:start_time]).round(3)}]
  end
end