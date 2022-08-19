class CommentsController < ApplicationController
    before_action :authenticate_user!, except: %i[create show index]

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
        flash[:notice] = "Comment added successfully."
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        if @article.user == current_user
          @comment.destroy
          redirect_to request.referrer
          flash[:notice] = "Comment deleted successfully."
        else
          redirect_to request.referrer
          flash[:alert] = "Only the writer of the article has the authority to delete comments."
        end
    end
     
      private
        def comment_params
          params.require(:comment).permit(:commenter, :body)
        end
end
