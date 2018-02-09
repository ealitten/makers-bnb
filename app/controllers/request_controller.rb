class Bnb < Sinatra::Base

  get 'requests/new' do
    # placeholder for page to create hire request (currently created straight from /spaces)
  end

  post '/requests' do
    if Request.first(space_id: params[:space_id], date: params[:date], approved: true)
      flash[:alert] = "Booked by another user"
    else
      Request.create(date: params[:date], user_id: session[:user_id], space_id: params[:space_id])
    end
    redirect '/requests'
  end

  get '/requests' do
    @requests = current_user.spaces.map { |space| space.requests }.flatten
    @new_requests = @requests.select{ |request| request.approved == nil }
    @approved_requests = @requests.select{ |request| request.approved == true }
    @my_requests = current_user.requests
    erb(:requests)
  end

  patch '/requests' do
    @hire_request = Request.get(params[:request_id])

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

end