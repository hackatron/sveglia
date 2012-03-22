class Scheduler < Goliath::API
  # parse query params and auto format JSON response
  use Goliath::Rack::Params
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render

  def response(env)
    delay = params['delay'] || 1

    EventMachine.add_timer delay, proc {
      deferrable = Pusher['timers'].trigger_async('end', {
        :message => "End of timer after #{delay} seconds"
      })

      deferrable.callback {
        logger.info "Pusher request callback end"
      }

      deferrable.errback { |error|
        logger.info "Pusher request callback error: #{error}"
      }

      logger.info "Timer end callback (after #{delay} seconds)"
    }

    [200, {'Content-Type' => 'application/json'}, {delay: delay, request_time: (Time.now.to_f - env[:start_time]).round(3)}]
  end
end