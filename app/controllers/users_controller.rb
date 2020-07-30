class UsersController < ApplicationController
  before_action :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

private

def correct_user #URL直打ち防止→ログインユーザー以外で他のユーザーの詳細画面に行けなくする
  user = User.find(params[:id])

  if current_user != user
    redirect_to root_path
  end
end


end
