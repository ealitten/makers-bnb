ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'securerandom'
require_relative 'datamapper_setup'

class Bnb < Sinatra::Base

  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

  # start the server if ruby file executed directly
  run! if app_file == $0

  get '/' do
    erb :signup
  end

  post '/users' do
    session[:user_name] = params[:name]
    session[:user_email] = params[:email]
    redirect '/users'
  end

  get '/users' do
    "Welcome " + session[:user_name]
  end

end