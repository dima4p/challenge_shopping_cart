class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_shopping_cart

  def current_ability
    Ability.new
  end

  private

  def set_shopping_cart
    session[:cart] ||= {}
    @shopping_cart = ShoppingCart.new.update session[:cart]
    logger.debug "ApplicationController@#{__LINE__}#set_shopping_cart #{@shopping_cart}" if logger.debug?
  end
end
