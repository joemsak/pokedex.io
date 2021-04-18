class SessionsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :require_no_authentication, except: :destroy

  def create
    @user = User.find_by(username: session_params[:username])

    if @user&.authenticate(session_params[:password])
      sign_in(@user, session_params)
      redirect_to user_dashboard_path
    else
      redirect_to new_session_path, alert: t(".alert")
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  private
  def session_params
    params.permit(:username, :password, :remember_me)
  end
end
