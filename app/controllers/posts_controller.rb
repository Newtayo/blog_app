class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = if params[:user_id].present?
              @user.posts.find(params[:author_id])
            else
              Post.find(params[:id])
            end
    @comments = @post.comments
  end
end
