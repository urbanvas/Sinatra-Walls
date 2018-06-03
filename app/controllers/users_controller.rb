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
      erb :"user/login"
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/show"
    else
      redirect "/"
    end
  end

  get "/show" do
    if logged_in?
      erb :"user/show"
    else
      redirect '/'
    end
  end

  get "/logout" do
    if session[:user_id] != nil
      session.destroy
      redirect to "/login"
    else
      redirect to "/"
    end
  end


end
