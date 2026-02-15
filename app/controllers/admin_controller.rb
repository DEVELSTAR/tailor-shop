class AdminController < ApplicationController
  before_action :require_authentication
  before_action :set_current_user
  
  helper_method :current_user
  
  private
  
  def require_authentication
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access the admin panel."
    end
  end
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def current_user
    @current_user || User.new # Fallback to prevent nil errors
  end
  
  def logged_in?
    session[:user_id].present?
  end
end
