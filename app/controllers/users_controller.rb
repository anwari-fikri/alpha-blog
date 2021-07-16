class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      user = User.find_by(email: user_params["email"].downcase)
      session[:user_id] = user.id
      session[:username] = user.username
      redirect_to root_path
    else
      render plain: @user.errors.full_messages
    end
  end

  def edit
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render plain: @user.errors.full_messages
    end
  end

  def destroy
    @user.destroy
    if current_user == @user
      session.destroy
    end
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :description, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        render plain: "wait... that's illegal"
      end
    end

end
