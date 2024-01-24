class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @name = @user.name if @user
    @text = @post.text
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.where(post_id: @posts.pluck(:id))
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    return if @post.save

    render 'new'
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
    if @post
      @post.comments.destroy_all
      @post.destroy
      flash[:notice] = 'Post was deleted.'
    else
      flash[:alert] = 'Post could not be found.'
    end
    redirect_to user_posts_path(@user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
