class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
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

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render plain: @user.errors.full_messages
    end
  end

  def show
    @articles = @user.articles
  end

  private

    def user_params
      params.require(:user).permit(:username, :description, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
