class ApplicationController < ActionController::Base
  AUTH_TOKEN = :auth_token

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by(auth_token: remembered_token || session_token)
  end

  def remembered_token
    cookies.encrypted.permanent[AUTH_TOKEN]
  end

  def session_token
    session[AUTH_TOKEN]
  end

  def sign_in(user, options = {})
    user.regenerate_auth_token

    session[AUTH_TOKEN] = user.auth_token

    if options[:remember_me]
      cookies.encrypted.permanent[AUTH_TOKEN] = user.auth_token
    end
  end

  def sign_out
    session.delete(AUTH_TOKEN)
    cookies.encrypted.permanent[AUTH_TOKEN] = nil
  end

  def authenticate_user!
    current_user || redirect_to(login_path, alert: t("alerts.unauthenticated"))
  end

  def require_no_authentication
    !current_user || redirect_to(user_dashboard_path)
  end
end
