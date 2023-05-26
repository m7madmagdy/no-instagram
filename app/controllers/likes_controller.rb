class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(likes_params)

    unless @like.save
      flash[:alert] = "You already liked this post"
    end
    redirect_to root_path
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
