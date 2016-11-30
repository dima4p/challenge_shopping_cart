products = Product.where()
json.content do
  json.array! @shopping_cart.content do |(product, count)|
    json.product do
      json.name product.name
      json.url  product_url product, format: 'json'
    end
    json.count count
  end
end
json.total @shopping_cart.total
