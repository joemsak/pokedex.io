class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: session_params[:username])

    if @user&.authenticate(session_params[:password])
      # sign_in(@user)
      redirect_to user_dashboard_path
    else
      redirect_to new_session_path, alert: t(".alert")
    end
  end

  private
  def session_params
    params.permit(:username, :password, :remember_me)
  end
end
