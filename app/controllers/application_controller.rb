class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_for_login

  def check_for_login
    @current_user = session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def not_logged_in?
    unless @current_user
      flash[:alert] = "Please log in"
      redirect_to root_path
      return true
    end
    false
  end
end
