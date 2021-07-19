class CategoriesController < ApplicationController
  def new
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

  def show
  end

  private
    def article_params
      params.require(:category).permit(:name)
    end
  
end
