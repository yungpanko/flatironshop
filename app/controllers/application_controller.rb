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

  def check_buyer_is_seller
    @items = []
    session[:cart].delete_if do |item_id|
      @item = Item.find(item_id)
      if @item.seller == current_user
        message = "#{@item.name} is being sold by you and cannot be added to your order."
        flash[:danger] ||= []
        flash[:danger] << message
      end
      @item.seller == current_user
    end
  end

end
