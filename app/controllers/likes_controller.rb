class LikesController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @likes = @post.likes.includes(:user)
  end

  def create
    @like = current_user.likes.new(likes_params)
    redirect_to root_path if @like.save
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to root_path
  end

  def likes_params
    params.require(:like).permit(:post_id)
  end
end
