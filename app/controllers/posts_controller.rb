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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
