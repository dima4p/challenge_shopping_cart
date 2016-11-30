# This is the main controller to process model ShoppingCart
#
class ShoppingCartsController < ApplicationController

  # GET /shopping_carts/1
  def show
  end

  # POST /shopping_carts
  def create
    shopping_cart_params.each do |id, count|
      @shopping_cart.add! id, count
    end
    session[:cart] = @shopping_cart
    respond_to do |format|
      format.html { redirect_to shopping_cart_url, notice: t('shopping_carts.was_created') }
      format.json { render :show, status: :created, location: @shopping_cart }
      format.js   { }
    end
  end

  # PATCH/PUT /shopping_carts/1
  def update
    @shopping_cart.update(shopping_cart_params)
    session[:cart] = @shopping_cart
    respond_to do |format|
      format.html { redirect_to root_url, notice: t('shopping_carts.was_updated') }
      format.json { render :show, status: :ok, location: @shopping_cart }
      format.js   { render 'create' }
    end
  end

  private

  def shopping_cart_params
    params[:shopping_cart] || {}
  end
end
