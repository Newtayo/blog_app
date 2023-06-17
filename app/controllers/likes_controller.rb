class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author: current_user)

    if @like.save
      redirect_to user_post_path(@user, @post)
    else
      redirect_to new_user_post_like_path(@user, @post), notice: 'Failed to like the post.'
    end
  end
end
