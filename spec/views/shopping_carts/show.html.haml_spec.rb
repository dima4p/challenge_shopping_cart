require 'rails_helper'

describe "shopping_carts/show", type: :view do
  let!(:product) {create :product}
  let(:shopping_cart) {ShoppingCart.new.add! product, 7}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :shopping_cart, shopping_cart
  end

  it "renders attributes in table" do
    render
    # expect(rendered).to eq ''

    assert_select "form[action='#{shopping_cart_path}'][method='post']" do
      assert_select 'tr>td', text: Regexp.new(product.name.to_s)
      assert_select 'input[name=?][value=?]', '_method', 'patch'
      assert_select "input#shopping_cart_#{product.id}[name=?]",
          "shopping_cart[#{product.id}]"
    end
    assert_select 'tr>td', text: shopping_cart.total.to_s
  end
end
