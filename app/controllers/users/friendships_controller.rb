class Users::FriendshipsController < ApplicationController
  def create
    return if not_logged_in?
    user = User.find(params[:user_id])
    if @current_user.verify_friendship?(user)
      flash[:alert] = "You are already friends!"
      redirect_to user_path(@current_user.id)
    elsif @current_user != user
      @current_user.make_friends_with(User.find(params[:user_id]))
      flash[:notice] = "Congrats! You are now friends with #{user.name}."
      redirect_to user_path(@current_user.id)
    end
  end

  def destroy
    return if not_logged_in?
    @current_user.delete_friend(User.find(params[:id]))
    flash[:notice] = "Successfully unfriended"
    redirect_to user_path(@current_user.id)
  end
end
