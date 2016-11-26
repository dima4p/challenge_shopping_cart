require 'rails_helper'

describe "products/show.json.jbuilder", type: :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    @product = assign(:product, create(:product))
    render
  end

  attributes = %w[
    id
    name
    price
    created_at
    updated_at
    url
  ]

  it "renders the following attributes of product: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @product.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = product_url(@product, format: 'json')
    expect(hash).to eq expected
  end
end
