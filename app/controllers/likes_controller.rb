class LikesController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @likes = @post.likes.includes(:user)
  end

  def create
    @like = current_user.likes.new(likes_params)
    @like.save
    respond_to do |format|
      redirect_path = post_path(@like.post)
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      redirect_path = post_path(@like.post)
    end
  end

  def likes_params
    params.require(:like).permit(:post_id)
  end
end
