class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  
  MAX_LOGIN_ATTEMPTS = 5
  SESSION_TIMEOUT = 30.minutes
  
  def new
    if logged_in?
      redirect_to admin_root_path, notice: "You are already logged in."
      return
    end
  end
  
  def create
    # Rate limiting
    if session[:login_attempts].to_i >= MAX_LOGIN_ATTEMPTS
      session[:login_attempts] = 0
      session[:lockout_time] = Time.current + SESSION_TIMEOUT
      redirect_to login_path, alert: "Too many failed login attempts. Please try again later."
      return
    end
    
    # Check if account is locked
    if session[:lockout_time]&.present? && session[:lockout_time] > Time.current
      redirect_to login_path, alert: "Account temporarily locked. Please try again later."
      return
    end
    
    user = User.find_by(email_address: params[:email_address])
    
    if user&.authenticate(params[:password])
      # Reset login attempts on successful login
      session[:login_attempts] = 0
      session[:lockout_time] = nil
      session[:user_id] = user.id
      session[:login_at] = Time.current
      session[:expires_at] = Time.current + 2.hours # Session expires in 2 hours
      
      # Log the login
      Rails.logger.info "User logged in: #{user.email_address} from #{request.remote_ip}"
      
      redirect_to admin_root_path, notice: "Welcome back, #{user.email_address.split('@').first}!"
    else
      # Increment failed attempts
      session[:login_attempts] = (session[:login_attempts] || 0) + 1
      
      # Log the failed attempt
      Rails.logger.warn "Failed login attempt for #{params[:email_address]} from #{request.remote_ip}"
      
      redirect_to login_path, alert: "Invalid email or password."
    end
  end
  
  def destroy
    user_id = session[:user_id]
    user = User.find_by(id: user_id)
    
    # Log the logout
    Rails.logger.info "User logged out: #{user.email_address} from #{request.remote_ip}"
    
    session.clear
    redirect_to root_path, notice: "Logged out successfully."
  end
  
  private
  
  def logged_in?
    session[:user_id].present?
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end
end
