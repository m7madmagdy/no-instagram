module Api
  class PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy ]

    def index
      @posts = Post.all
    end

    def show; end

    def create
      @post = Post.new(post_params)

      if @post.save
        render :show, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :keywords, images: [])
    end
  end
end
