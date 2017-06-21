class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_cart
  require 'carrierwave/orm/activerecord'


  def current_cart
    session[:cart] ||= []
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    session[:return_to] = request.url
    redirect_to login_path unless logged_in?
  end

  def require_admin
    unless current_user.try(:admin)
      flash[:danger] = "You must be an admin for that action."
      redirect_to root_path
    end
  end

  def redirect_back_or_default(default_path)
    redirect_to(session[:return_to] || default_path)
    session[:return_to] = nil
  end
end
