class Users::FriendshipsController < ApplicationController
  def create
    unless @current_user
      flash[:alert] = "Please log in"
      redirect_to root_path
      return
    end
    if @current_user.verify_friendship?(User.find(params[:user_id]))
      flash[:alert] = "You are already friends!"
      redirect_to user_path(@current_user.id)
    elsif @current_user != User.find(params[:user_id])
      @current_user.make_friends_with(User.find(params[:user_id]))
      flash[:notice] = "Congrats! You are now friends with #{User.find(params[:user_id]).name}."
      redirect_to user_path(@current_user.id)
    end
  end

  def destroy
    if @current_user 
      @current_user.delete_friend(User.find(params[:id]))
      flash[:notice] = "Successfully unfriended"
      redirect_to user_path(@current_user.id)
    else
      flash[:alert] = "Action not permitted."
      redirect_to root_path
    end
  end
end
