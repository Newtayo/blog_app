class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author: @user, post: @post, text: comment_params[:text])
    respond_to do |format|
      if @comment.save
        format.html do
          redirect_to user_posts_path(user_id: @post.author, id: @post.id, author_id: @post.id),
                      notice: 'Comment created successfully.'
        end
        format.json { render json: @comment, status: :created }


      else
        format.html do
          render :new, notice: 'Comment was not saved.'
        end
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
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
