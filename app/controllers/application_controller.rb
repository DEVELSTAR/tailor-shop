class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_authentication
    redirect_to login_path, alert: "Please login first." unless current_user
  end
end
