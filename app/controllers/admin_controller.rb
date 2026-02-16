class AdminController < ApplicationController
  before_action :require_authentication
  before_action :set_current_user
  before_action :log_suspicious_requests
  
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
  
  def log_suspicious_requests
    suspicious_paths = %w[host sync trigger synctriggers]
    request_path = request.path.downcase
    
    if suspicious_paths.any? { |path| request_path.include?(path) }
      Rails.logger.warn "Suspicious admin request: #{request.method} #{request.path} from #{request.remote_ip}"
      head :forbidden
    end
  end
end
