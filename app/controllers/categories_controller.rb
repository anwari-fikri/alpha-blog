class CategoriesController < ApplicationController
  before_action :require_user, except: [:show, :new, :create]
  before_action :require_admin, except: [:index, :show]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category
    else
      render plain: @category.errors.full_messages
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
  
    def require_admin
      if !(logged_in? && current_user.admin?)
        render plain: "wait... that's illegal"
      end
    end

end
