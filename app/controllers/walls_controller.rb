class WallsController < ApplicationController

  get "/show" do
    @user = current_user
    if logged_in?
      erb :"user/show"
    else
      redirect "/"
    end
  end

  get '/walls/new' do
    @user = current_user
    if logged_in?
      erb :"wall/create_wall"
    end
  end

  post "/walls" do
    @wall = Wall.create(location: params[:location], user_id: current_user.id)
  end

end
