require 'rails_helper'

describe "products/index.json.jbuilder", type: :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    @product = create(:product)
    assign :products, [@product, @product]
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

  it "renders a list of products as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @product.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = product_url(@product, format: 'json')
    expect(hash).to eq expected
  end
end
