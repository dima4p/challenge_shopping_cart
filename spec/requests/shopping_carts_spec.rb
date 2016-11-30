require 'rails_helper'

describe "ShoppingCarts", type: :request do
  before :each do
    allow_any_instance_of(ShoppingCartsController).to receive(:current_ability).and_return(current_ability)
  end

  describe "GET /shopping_carts" do
    it "works! (now write some real specs)" do
      get shopping_cart_path
      expect(response).to have_http_status(200)
    end
  end
end
