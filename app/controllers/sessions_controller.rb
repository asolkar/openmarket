class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You are already logged as " + current_user.fullname
      redirect_to '/'
      return false
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
