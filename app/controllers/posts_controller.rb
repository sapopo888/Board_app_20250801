class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user) #全てのユーザーが全ての投稿を閲覧可能
    # @posts = current_user.posts # 現在ログインしているユーザーの投稿のみ閲覧可能
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
