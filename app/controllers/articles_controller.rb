class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    @article = Article.new
    @users = User.all
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      redirect_to articles_path
    else
      render plain: @article.errors.full_messages
    end
  end

  def edit
  end

  def show
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
      params.require(:article).permit(:title, :description, category_ids: [])
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        render plain: "wait... that's illegal"
      end
    end

end
