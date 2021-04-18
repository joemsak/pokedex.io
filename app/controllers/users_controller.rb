class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :require_no_authentication, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to user_dashboard_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
