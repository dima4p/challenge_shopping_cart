require 'rails_helper'

describe ShoppingCartsController, type: :controller do
  before :each do
    allow(controller).to receive(:current_ability).and_return(current_ability)
  end

  let!(:product) {create :product}

  let(:valid_attributes) {{product.id.to_s => '2'}}

  let(:invalid_attributes) do
    {(product.id + 1) => '3'}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ShoppingCartsController. Be sure to keep this updated too.
  let(:valid_session) { {cart: {product.id => 5}} }

  describe "GET #show" do
    it "assigns the user's shopping cart as @shopping_cart" do
      get :show, session: valid_session
      expect(assigns(:shopping_cart)).to be_a(ShoppingCart)
    end
  end

  describe "POST #create" do
    it "changes the ShoppingCart kept in session" do
      post :create,
          params: {shopping_cart: valid_attributes},
          session: valid_session
      expect(session[:cart]).to eq 1 => 7
    end

    it "assigns @shopping_cart" do
      post :create,
          params: {shopping_cart: valid_attributes},
          session: valid_session
      expect(assigns(:shopping_cart)).to be_a(ShoppingCart)
    end

    it "redirects to shopping_cart_url" do
      post :create,
          params: {shopping_cart: valid_attributes},
          session: valid_session
      expect(response).to redirect_to(shopping_cart_url)
      # expect(response).to redirect_to(shopping_carts_url)
    end
  end   # POST #create

  describe "PUT #update" do
    let(:new_attributes) {{product.id.to_s => '3'}}

    it "updates the user's shopping cart" do
      put :update,
          params: {shopping_cart: new_attributes},
          session: valid_session
      expect(session[:cart][product.id]).to eq 3
    end

    it "assigns the user's shopping cart as @shopping_cart" do
      put :update,
          params: {shopping_cart: valid_attributes},
          session: valid_session
      expect(assigns(:shopping_cart)).to eq(session[:cart])
    end

    it "redirects to root_url" do
      put :update,
          params: {shopping_cart: valid_attributes},
          session: valid_session
      expect(response).to redirect_to(root_url)
    end
  end   # PUT #update
end
