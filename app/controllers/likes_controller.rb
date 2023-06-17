class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(author_id: @user.id, post_id: @post.id)

    if @like.save
      redirect_to user_post_path(@user, @post)
    else
      redirect_to new_user_post_like_path(@user, @post), notice: 'Failed to like the post.'
    end
  end
end
