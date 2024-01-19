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
end
