require 'rails_helper'

describe "shopping_carts/show.json.jbuilder", type: :view do
  let!(:product) {create :product}
  let(:shopping_cart) {ShoppingCart.new.update product.id => 5}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign(:shopping_cart, shopping_cart)
    render
  end

  attributes = %w[
    content
    total
  ]

  content_attributes = %w[
    product
    count
  ]

  product_attributes = %w[
    name
    url
  ]

  it "renders the following attributes of shopping_cart: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = {'total' => shopping_cart.total}
    expected = MultiJson.load MultiJson.dump expected
    expect(hash.except! 'content').to eq expected
  end

  it "renders the following attributes in the array of content: #{content_attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    array = hash['content']
    expect(array).to be_an Array
    hash = array.first
    expect(hash.keys.sort).to eq content_attributes.sort
    expected = {'count' => 5}
    expected = MultiJson.load MultiJson.dump expected
    expect(hash.except! 'product').to eq expected
  end

  it "renders the following attributes of product: #{product_attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    hash = hash['content'].first['product']
    expect(hash.keys.sort).to eq product_attributes.sort
    expected = {'name' => product.name}
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = product_url(product, format: 'json')
    expect(hash).to eq expected
  end
end
