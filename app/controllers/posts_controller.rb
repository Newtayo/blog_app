class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).where(author_id: params[:user_id])
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

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_posts_path(@user), notice: 'Post created successfully.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
