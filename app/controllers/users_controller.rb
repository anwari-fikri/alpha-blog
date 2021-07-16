class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :new]
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
      redirect_to @user
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

  private

    def user_params
      params.require(:user).permit(:username, :description, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user
        render plain: "wait... that's illegal"
      end
    end

end
