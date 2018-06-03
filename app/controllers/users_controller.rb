class UsersController < ApplicationController

  get "/signup" do
    if !session[:user_id]
      erb :"user/signup"
    else
      redirect to '/show'
    end
  end

  post "/signup" do
    if !(params[:username].empty? || params[:password].empty? || params[:email].empty?)
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/show'
    else
      redirect '/signup'
    end
  end

  get "/login" do
    if logged_in?
      redirect "/show"
    else
      redirect "/login"
    end
  end

  get "/show" do
    "Show page"
  end


end
