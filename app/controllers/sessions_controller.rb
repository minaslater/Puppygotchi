class SessionsController < ApplicationController
  def new
  end

  def create
    logged_in_user = User.login(params[:email], params[:password])
    if logged_in_user
        session[:user_id] = logged_in_user.id
        redirect_to user_path(logged_in_user.id)
    else
      invalid_attempt
    end
  end

  private

    def invalid_attempt
      flash[:alert] = "email/password combination does not match"
      redirect_back(fallback_location: new_session_path)
    end
end
