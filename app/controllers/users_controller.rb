class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_current_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome!"
      redirect_to action: "show", id: @user.id
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to action: "new"
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "updated!"
      redirect_to action: "show", id: @user.id
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to action: "edit", id: @user.id
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "byeeeeeeee!"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path) 
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def validate_current_user
      unless @current_user == @user
        flash[:alert] = "Action not permitted" 
        redirect_back(fallback_location: root_path)
      end
    end

    def find_user
      @user = User.find(params[:id])
    end
end
