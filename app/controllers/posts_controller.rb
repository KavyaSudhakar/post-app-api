class PostsController < ApplicationController
  
  def index
    posts = Post.all
    render json: posts
  end

  def show
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: @current_user.id)
  end
end
