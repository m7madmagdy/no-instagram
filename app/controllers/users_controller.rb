class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :follow, :unfollow, :accept, :decline, :cancel]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @users = search
  end

  def show; end

  def follow
    current_user.send_follow_request_to(@user)
    @user.accept_follow_request_of(current_user)
    redirect_to user_path(@user)
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to user_path(@user)
  end

  def accept
    current_user.accept_follow_request_of(@user)
    redirect_to user_path(@user)
  end

  def decline
    current_user.decline_follow_request_of(@user)
    redirect_to user_path(@user)
  end

  def cancel
    current_user.remove_follow_request_for(@user)
    redirect_to user_path(@user)
  end

  def destroy
    respond_to do |format|
      if current_user.admin?
        @user.destroy
        format.html { redirect_to users_path, alert: "User deleted." }
      else
        format.html { redirect_to users_path, alert: "You don't have permission to do that." }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search
    @query = User.ransack(username_cont: search_query)
    @users = @query.result(distinct: true)
  end

  def search_query
    params[:query]
  end
end