class Users::AllPostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).where(created_at: Date.today.beginning_of_day..Date.today.end_of_day) # 全ユーザーの投稿を表示
  end
end
