class PostsController < ApplicationController
  def index
    # @posts = Post.includes(:user) # 全てのユーザーが全ての投稿を閲覧可能
    @posts = current_user.posts # 現在ログインしているユーザーの投稿のみ閲覧可能
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = t("flash_message.post.created")
      redirect_to posts_path, status: :see_other
    else
      flash.now[:danger] = t("flash_message.post.not_created")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:success] = t('flash_message.post.updated')
      redirect_to posts_path(@post)
    else
      flash.now[:danger] = t('flash_message.post.not_updated')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
