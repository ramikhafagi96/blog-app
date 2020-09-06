class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end
  
  def create
    @article = Article.new(whitlist_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article Was Created Successfully"
      redirect_to @article   # redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(whitlist_params)
      flash[:notice] = "Article Updated Successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def whitlist_params
    params.require(:article).permit(:title, :description)
  end
end