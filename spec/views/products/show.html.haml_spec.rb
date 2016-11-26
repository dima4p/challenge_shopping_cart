require 'rails_helper'

describe "products/show", type: :view do
  let(:product) {create :product}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :product, product
  end

  it "renders attributes in dl>dd" do
    render
    assert_select 'dl>dd', text: Regexp.new(product.name.to_s)
    assert_select 'dl>dd', text: Regexp.new(product.price.to_s)
  end
end
