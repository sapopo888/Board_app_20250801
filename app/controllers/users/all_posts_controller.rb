class Users::AllPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user) # 全ユーザーの投稿を表示
  end
end
