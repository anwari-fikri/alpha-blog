class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :new, :create]
  before_action :require_admin, except: [:index, :show]
  before_action :setup_nav, only: [:index, :show]

  def new
    @category = Category.new
  end

  def index
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      render plain: @category.errors.full_messages
    end
  end

  def edit
  end

  def show
    @articles = @category.articles
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render plain: @category.errors.full_messages
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  
    def require_admin
      if !(logged_in? && current_user.admin?)
        render plain: "[categories] wait... that's illegal. Only admin can do that."
      end
    end

end
