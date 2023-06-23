class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author: @user, post: @post, text: comment_params[:text])
    if @comment.save
      redirect_to user_posts_path(user_id: @post.author, id: @post.id, author_id: @post.id),
                  notice: 'Comment created successfully.'
    else
      render :new
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to user_posts_path(user_id: @post.author, id: @post.id, author_id: @post.id),
                notice: 'Comment Deleted successfully.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
