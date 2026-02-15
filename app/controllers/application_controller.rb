class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_security_headers
  
  private
  
  def set_security_headers
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    response.headers['Strict-Transport-Security'] = 'max-age=31536000; includeSubDomains; preload'
    response.headers['Referrer-Policy'] = 'strict-origin-when-cross-origin'
    response.headers['Content-Security-Policy'] = "default-src 'self'; script-src 'self' 'unsafe-inline';"
  end
  
  def require_login
    redirect_to login_path, alert: "Please log in to continue."
  end
end
