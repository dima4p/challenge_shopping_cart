# == Schema Information
#
# Table name: products
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(15, 2)
#  updated_at :datetime         not null
#

# This is the main controller to process model Product
#
class ProductsController < ApplicationController

  load_and_authorize_resource

  # GET /products
  def index
    @products = @products.ordered
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: t('products.was_created') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: t('products.was_updated') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t('products.was_deleted') }
      format.js do
        if Product.accessible_by(current_ability).count == 0
          redirect_to products_url, notice: t('products.was_deleted')
        end
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_product
  #   @product = Product.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    list = [
      :name, :price
    ]
    params.require(:product).permit(*list)
  end
end
