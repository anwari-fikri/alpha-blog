class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    @article = Article.new
    @users = User.all
  end

  def show

  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first

    if @article.save
      redirect_to articles_path
    else
      render plain: @article.errors.full_messages
    end
  end

  def edit
    
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render plain: @article.errors.full_messages
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end


  private

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def set_article
      @article = Article.find(params[:id])
    end

end
