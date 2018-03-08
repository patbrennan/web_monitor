class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    access_denied unless logged_in?
  end
  
  def require_same_user
    access_denied unless logged_in? && current_user == @user || current_user.admin?
  end
  
  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end
  
  def access_denied
    flash[:error] = "You don't have permission to do that."
    redirect_to root_path
  end
end
