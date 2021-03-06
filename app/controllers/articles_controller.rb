class ArticlesController < ApplicationController

  #before action will run the method(find_article) in the specified routes
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
      @articles=Article.paginate(page: params[:page], per_page: 3)
  end

  def new
      #for first time we visit /new (required in new.index.html) ohervise nill error will appear
      @article=Article.new
  end

  def create
      #render plain: params[:article] #for rendering at webpage
      #creating article object by taking values from the FORM
      #permit is security feature
      @article = Article.new(article_params)
      #specifying the sign-in user as the author of the article
      @article.user=current_user
      if @article.save #if article passed validations (than save)
          #redirecting to the created article(show route) after button is pressed
          redirect_to @article
          #we use flash notice(hash) for success & flash alert(also a hash) for error
          flash[:notice]="Article was created successfully"
      else #else reload the page
          render 'new'
      end
      #render plain: @article.inspect
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
      flash[:notice]="Article updated successfully"
    else
        render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  #refactoring
  private
  def find_article
    #finding articles with id from https address i.e (articles/1)
    @article=Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit and delete your own articles"
      redirect_to @article
    end
  end
end
