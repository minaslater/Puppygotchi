class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:suceess] = "welcome!"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to action: "new"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
