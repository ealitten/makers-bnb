ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'securerandom'
require_relative 'datamapper_setup'
require_relative 'helpers'

class Bnb < Sinatra::Base

  # helper methods
  helpers Helpers

  # server config
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  register Sinatra::Flash
  use Rack::MethodOverride

  # start the server if ruby file executed directly
  run! if app_file == $0

  get '/' do
    redirect '/users/new'
  end

  get '/users/new' do
    erb :signup
  end

  post '/users' do
    @user = User.new(username: params[:name],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/users'
    else
      redirect '/users/new'
    end
  end

  get '/users' do
    erb(:welcome)
  end

  get '/spaces/new' do
    erb(:list_space)
  end

  post '/spaces/hire' do
    Hire.create(date: params[:date], user_id: session[:user_id], space_id: params[:space_id])
    redirect '/users'
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

  get '/sessions/new' do
    erb(:login)
  end

  post '/sessions' do
    @user = User.first(params[:name])
    if @user.nil? || @user.password != params[:password]
      flash.now[:error] = 'Username or password is incorrect'
      erb(:login)
    else
      session[:user_id] = @user.id
      redirect '/users'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/users'
  end

end
