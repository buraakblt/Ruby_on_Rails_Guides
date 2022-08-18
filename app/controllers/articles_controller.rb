class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: %i[search show index]
   
    def index
        @q = Article.ransack(params[:q])
        @articles = @q.result(distinct: true)
    end

    def search
        @articles = Article.where("title LIKE ? OR text LIKE ? OR id LIKE ?", "%" + params[:q] + "%", "%" + params[:q] + "%", "%" + params[:q] + "%")
    end

    def show
        @article = Article.find(params[:id])
        views = @article.views + 1
        @article.views = views
        @article.save
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
 
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

    private
        def article_params
            params.require(:article).permit(:title, :text)
        end
end
