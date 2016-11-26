require 'rails_helper'

describe "products/index", type: :view do
  let(:product) {create :product}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    product  # to create
    assign :products, Product.all
  end

  it "renders a list of products" do
    render

    assert_select 'tr>td', text: product.name.to_s, count: 1
    assert_select 'tr>td', text: product.price.to_s, count: 1

  end

end
