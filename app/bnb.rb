ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'securerandom'
require_relative 'datamapper_setup'
require_relative 'helpers'

class Bnb < Sinatra::Base

  helpers Helpers

  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

  # start the server if ruby file executed directly
  run! if app_file == $0

  get '/' do
    erb :signup
  end

  post '/users' do
    @user = User.create(username: params[:name], email: params[:email])
    session[:user_id] = @user.id
    redirect '/users'
  end

  get '/users' do
    "Welcome " + current_user.username
  end

  get '/spaces/new' do
    erb(:list_space)
  end

  post '/spaces' do
    @space = Space.create(title: params[:title],
                          description: params[:description],
                          price: params[:price],
                          user_id: current_user.id)
    redirect '/spaces'
  end

  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end

end
