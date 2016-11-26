require 'rails_helper'

describe ProductsController, type: :controller do
  before :each do
    allow(controller).to receive(:current_ability).and_return(current_ability)
  end

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well. The list could not be empty.
  let(:product) {create :product}

  let(:valid_attributes) {attributes_for(:product).slice *%w[name price].map(&:to_sym)}

  let(:invalid_attributes) do
    {name: ''}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all products as @products" do
      product
      get :index, params: {}, session: valid_session
      expect(assigns(:products)).to be_kind_of(ActiveRecord::Relation)
      expect(assigns(:products)).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      get :show,
          params: {id: product.to_param},
          session: valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      get :new, params: {}, session: valid_session
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      get :edit, params: {id: product.to_param},
          session: valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect do
          post :create,
              params: {product: valid_attributes},
              session: valid_session
        end.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create,
            params: {product: valid_attributes},
            session: valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create,
            params: {product: valid_attributes},
            session: valid_session
        expect(response).to redirect_to(products_path)
        # expect(response).to redirect_to(products_url)
      end
    end   # with valid params

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        # allow_any_instance_of(Product).to receive(:save).and_return(false)
        post :create,
            params: {product: invalid_attributes},
            session: valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        # allow_any_instance_of(Product).to receive(:save).and_return(false)
        post :create,
            params: {product: invalid_attributes},
            session: valid_session
        expect(response).to render_template("new")
      end
    end   # with invalid params
  end   # POST #create

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: 'New value'} }

      it "updates the requested product" do
        put :update,
            params: {id: product.to_param,
                     product: new_attributes},
            session: valid_session
        product.reload
        # skip("Add assertions for updated state")
        expect(product.name).to eq 'New value'
      end

      it "assigns the requested product as @product" do
        put :update,
            params: {id: product.to_param,
                     product: valid_attributes},
            session: valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "redirects to the product" do
        put :update,
            params: {id: product.to_param,
                     product: valid_attributes},
            session: valid_session
        expect(response).to redirect_to(products_path)
      end
    end  # with valid params

    context "with invalid params" do
      it "assigns the product as @product" do
        put :update,
            params: {id: product.to_param,
                     product: invalid_attributes},
            session: valid_session
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        put :update,
            params: {id: product.to_param,
                     product: invalid_attributes},
            session: valid_session
        expect(response).to render_template("edit")
      end
    end   # with invalid params
  end   # PUT #update

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product
      expect do
        delete :destroy,
            params: {id: product.to_param},
            session: valid_session
      end.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product
      delete :destroy,
          params: {id: product.to_param},
          session: valid_session
      expect(response).to redirect_to(products_url)
    end
  end   # DELETE #destroy

end
