class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    redirect_to root_path
  end
end
