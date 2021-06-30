class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to articles_path
    else
      render plain: @article.errors.full_messages
    end
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end

end
