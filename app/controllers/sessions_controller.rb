class SessionsController < ApplicationController

  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email_or_username].downcase)
    if !user
      user = User.find_by(username: params[:session][:email_or_username].downcase)
    end

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:username] = user.username
      redirect_to root_path
    else
      render plain: "incorrect info"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    redirect_to root_path
  end

end
