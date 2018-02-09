class Bnb < Sinatra::Base
  
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

end