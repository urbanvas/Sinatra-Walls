class UsersController < ApplicationController

  get "/users/:id" do
    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :"user/show"
    end
    
    if !logged_in?
      redirect "/show"
    else
      redirect "/"
    end
  end


  get "/signup" do
    if !session[:user_id]
      erb :"user/signup"
    else
      redirect to "/show"
    end
  end

  post "/signup" do
    if User.find_by(username: params[:username])
      flash[:message] = "Profile exists"
      # get flash message to show up
      redirect "/signup"
    elsif !(params[:username].empty? || params[:password].empty? || params[:email].empty?)
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/show"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/show"
    else
      erb :"user/login"
    end
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/show"
    else
      redirect "/"
    end
  end

  get "/logout" do
    if session[:user_id] != nil
      session.destroy
      redirect to "/"
    else
      redirect to "/"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"user/show"
  end


end
