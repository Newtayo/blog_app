class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author: @user, post: @post, text: params[:comment][:text])
    if @comment.save
      redirect_to user_post_path(user_id: @post.author, id: @post.id, author_id: @post.id), notice: 'Comment created successfully.'
    else
      render :new
    end
  end
end
