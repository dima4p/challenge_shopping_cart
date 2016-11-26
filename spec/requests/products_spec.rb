require 'rails_helper'

describe "Products", type: :request do
  before :each do
    allow_any_instance_of(ProductsController).to receive(:current_ability).and_return(current_ability)
  end

  describe "GET /products" do
    it "works! (now write some real specs)" do
      get products_path
      # expect(response).to have_http_status(200)
    end
  end
end
