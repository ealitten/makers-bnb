class Bnb < Sinatra::Base

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

end