class ApplicationController < ActionController::Base
  AUTH_TOKEN = :auth_token

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by(auth_token: session[AUTH_TOKEN])
  end

  def sign_in(user, params = {})
    user.regenerate_auth_token

    session[AUTH_TOKEN] = user.auth_token

    if params[:remember_me]
      cookies.encrypted.permanent[AUTH_TOKEN] = user.auth_token
    end
  end
end
