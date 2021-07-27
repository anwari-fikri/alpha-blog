class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_user
    if !logged_in?
      redirect_to login_path
    end
  end

  def setup_navbar
    @users = User.all
    @categories = Category.all
  end

end
