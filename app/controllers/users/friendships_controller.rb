class Users::FriendshipsController < ApplicationController
  def create
    if @current_user
      @current_user.make_friends_with(User.find(params[:user_id]))
      # TODO: add redirect
    else
    end
  end

  def destroy
    if @current_user == User.find(params[:user_id])
      @current_user.delete_friend(User.find(params[:id]))
      redirect_to user_path(@current_user.id)
    else
      flash[:alert] = "Action not permitted."
      redirect_to root_path
    end
  end
end
