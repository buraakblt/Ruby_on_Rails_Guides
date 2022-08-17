class ArticlesController < ApplicationController
    before_action :set_search

    http_basic_authenticate_with name: "buraakblt", password: "123456", except: [:index, :show]
   
    def index
        @articles = @q.result(distinct: true)
    end

    def set_search
        @q = Article.ransack(params[:q])
    end

    def search
        @articles = Article.where("title LIKE ? OR text LIKE ? OR id LIKE ?", "%" + params[:q] + "%", "%" + params[:q] + "%", "%" + params[:q] + "%")
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)
 
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
