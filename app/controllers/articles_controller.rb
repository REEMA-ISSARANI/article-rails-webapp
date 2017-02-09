class ArticlesController < ApplicationController
 
 before_action :logged_in_user

 def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    #@article = Article.new(article_params)

    #@article = Article.new(article_params).merge(:user_id => current_user.id)
    puts current_user.name
    @article = current_user.articles.build(article_params)
    #@like = @article.likes.build(article_params)

    if @article.save
     redirect_to @article
    else
     render 'new'
   end
  end
   
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
       redirect_to @article
    else
       render 'edit'
    end
  end 

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def Like
    #@user = current_user
    @article = Article.find(params[:id])
   # like = Like.new
   #like.article_id = @article.id
   # like.user_id = current_user.id
   # like.save!
    #@users = @user.likes.build(params[:id])
    if @article.likes.create(user_id: current_user.id)
       redirect_to(articles_path)
    else
       flash[:notice] =  "already liked!"
       redirect_to(articles_path)
    end
    #@user.Like!(@article)
    #@user = current_user
    #@article = current_user.likes.build(article_params)
      #flash[:notice] =  "already liked!"
      #redirect_to(articles_path)

  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :user_id)
    end  

  def logged_in_user
      unless logged_in?
        flash[:sorry] = "Please log in"
        redirect_to login_path
      end
    end   
end

 