class UsersController < ApplicationController

  get "/users/:id" do
    @user = User.find(id: params[:id])
    if !@user.nil? && @user == current_user
      erb :"user/show"
    end
    if !logged_in?
      redirect "/show"
    else
      flash[:message] = "Please login"
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
      flash[:message] = "Username exists"
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
      flash[:message] = "!!!!Auto Logged In!!!!"
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
      flash[:notice] # => "Thanks for signing up!"
      redirect "/"
    end
  end

  get "/logout" do
    if session[:user_id] != nil
      session.destroy
      flash[:message] = "Logged Out!!!"
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
