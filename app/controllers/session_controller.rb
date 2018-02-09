class Bnb < Sinatra::Base

  get '/sessions/new' do
    @signin_page = true
    erb(:signin)
  end

  post '/sessions' do
    @user = User.first(username: params[:name])
    if @user.nil? || @user.password != params[:password]
      flash.now[:error] = 'Username or password is incorrect'
      erb(:signin)
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