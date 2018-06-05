class WallsController < ApplicationController

  get "/show" do
    if logged_in?
      erb :"user/show"
    else
      redirect "/"
    end
  end

  get '/walls/new' do
    if logged_in?
      erb :"wall/create_wall"
    end
  end

end
