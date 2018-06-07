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

  get "/walls/:id" do
    @wall = Wall.find_by(id: params[:id])
    erb :"wall/show_wall"
  end

  post "/walls" do
    @wall = Wall.create(location: params[:location],name: params[:name], user_id: current_user.id)
    redirect "/show"
  end

  get "/walls/:id/edit" do
    @wall = Wall.find_by(id: params[:id])
    erb :"wall/edit_wall"
  end

  patch "/walls/:id/edit" do
    @wall = Wall.find_by(id: params[:id])
    @wall.name = params[:name] if params[:name] != ""
    @wall.location = params[:location] if params[:location] != ""
    @wall.save
    redirect "/show"
  end

  # Should my delete CRUD be a get request?
  get "/walls/:id/delete" do
    @wall = Wall.find_by(id: params[:id])
    @wall.destroy
    redirect "/show"
  end

end
