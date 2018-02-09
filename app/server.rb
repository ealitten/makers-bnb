class Bnb < Sinatra::Base

  helpers Helpers

  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  set :partial_template_engine, :erb
  enable :partial_underscores

  # start the server if ruby file executed directly
  run! if app_file == $0

end
