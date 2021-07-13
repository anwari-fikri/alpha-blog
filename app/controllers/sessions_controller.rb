class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:username] = user.username
      redirect_to user
    else
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    redirect_to root_path
  end

end
