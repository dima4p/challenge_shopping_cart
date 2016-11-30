require "rails_helper"

RSpec.describe ShoppingCartsController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/shopping_cart").to route_to("shopping_carts#show")
    end

    it "routes to #create" do
      expect(:post => "/shopping_cart").to route_to("shopping_carts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shopping_cart").to route_to("shopping_carts#update")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shopping_cart").to route_to("shopping_carts#update")
    end

  end
end
