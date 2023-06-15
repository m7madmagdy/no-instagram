class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = search
  end

  private
  def search
    @query = User.ransack(username_cont: search_query)
    @users = @query.result(distinct: true)
  end

  def search_query
    params[:query]
  end
end
