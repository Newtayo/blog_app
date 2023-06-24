class PostsController < ApplicationController
  # load_and_authorize_resource
  def index
    @posts = Post.includes(:comments).where(author_id: params[:user_id])
    @user = User.includes(:posts).find(params[:user_id])
    respond_to do |format|
      format.html
      format.json { render json: @posts, include: :comments }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = if params[:user_id].present?
              @user.posts.find(params[:post_id])
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

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @user = @post.author
    @comment = @post.comments.where(post_id: @post.id)
    @comment.each(&:destroy)
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post Deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
