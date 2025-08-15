class Users::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = current_user.posts.order(created_at: :desc) # 現在ログインしているユーザーの投稿のみ閲覧可能
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = t("flash_message.post.created")
      redirect_to user_posts_path, status: :see_other
    else
      flash.now[:danger] = t("flash_message.post.not_created")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def edit
    @user = current_user
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = t("flash_message.post.updated")
      redirect_to user_posts_path
    else
      flash.now[:danger] = t("flash_message.post.not_updated")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to user_posts_path, success: t("flash_message.post.deleted"), status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
