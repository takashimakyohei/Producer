class UsersController < ApplicationController

  def show
    if current_user 
    @user = User.find(params[:id])
    else
    redirect_to root_path
    end
  end
end
