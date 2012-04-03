environment :production do
  ::Pusher.app_id = ENV['PUSHER_APP_ID']
  ::Pusher.key    = ENV['PUSHER_KEY']
  ::Pusher.secret = ENV['PUSHER_SECRET']
end

environment :development do
  begin
    PUSHER_CONFIG = YAML.load_file(Goliath::Application.app_path('config', 'pusher.yml'))
  rescue
    throw "Missing Pusher's configuration, try 'cp config/pusher.example.yml config/pusher.yml'"
  end

  ::Pusher.app_id = PUSHER_CONFIG['PUSHER_APP_ID']
  ::Pusher.key    = PUSHER_CONFIG['PUSHER_KEY']
  ::Pusher.secret = PUSHER_CONFIG['PUSHER_SECRET']
end

environment :test do
  logger.info 'test.example.org'
end

pool_size = ENV['REDIS_POOL_SIZE'] || 1
config['redis_pool'] = EM::Synchrony::ConnectionPool.new(size: pool_size) do
  Redis.new
end
