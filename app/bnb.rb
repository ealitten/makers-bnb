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

  # users routes

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

  # spaces routes

  get '/spaces/new' do
    erb(:list_space)
  end

  post '/spaces' do
    @space = Space.create(title: params[:title],
                          description: params[:description],
                          price: params[:price],
                          availability_start: params[:availability_start],
                          availability_end: params[:availability_end],
                          user_id: current_user.id)
    redirect '/spaces'
  end
 
  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end

  # requests routes

  post '/spaces/hire' do #todo: rename to requests/new
    Hire.create(date: params[:date], user_id: session[:user_id], space_id: params[:space_id])
    redirect '/users'
  end

  get '/requests' do
    @requests = current_user.spaces.map { |space| space.hires }.flatten
    erb(:requests)
  end

  post '/requests' do
    @hire_request = Hire.get(params[:request_id])

    if params[:action] == 'approve'
      @hire_request.update(approved: true)
      flash.next[:notice] = "Request approved" 
    end
    if params[:action] == 'deny'
      @hire_request.update(approved: false)
      flash.next[:notice] = "Request denied"
    end

    redirect '/requests'
  end

  # sessions routes

  get '/sessions/new' do
    erb(:login)
  end

  post '/sessions' do
    @user = User.first(username: params[:name])
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
