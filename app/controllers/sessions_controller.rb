class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      if BCrypt::Password.create(params[:password]) == @user.password_digest

      else
        flash[:alert] = "email/password combination does not match"
        redirect_back(fallback_location: new_session_path)
      end
    else
      flash[:alert] = "email/password combination does not match"
      redirect_back(fallback_location: new_session_path)
    end
  end
end
