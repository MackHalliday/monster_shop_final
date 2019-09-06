class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant_admin?
    current_user && current_user.merchant_admin?
  end

  def current_admin?
    current_user && current_user.admin_user?
  end

  def visitor_with_items?
    current_user.nil? && cart.contents.present?
  end
end
