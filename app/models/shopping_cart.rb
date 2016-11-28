# Model ShoppingCart defines the shopping cart
#
class ShoppingCart < Hash
  include ActiveModel::Validations

  def initialize
    super 0
  end

  def [](key)
    key = key.id if key.is_a? Product
    super key
  end

  def add!(product, count = 1)
    product = Product.find product unless product.is_a? Product
    count = 1 if count.blank?
    self[product.id] += count.to_i
  end

  def content
    Product.where(id: keys).ordered.map do |product|
      [product, self[product.id]] if self[product.id] > 0
    end.compact
  end

  def drop!(product)
    product = Product.find product unless product.is_a? Product
    except! product.id
  end

  def set!(product, count)
    product = Product.find product unless product.is_a? Product
    if count.to_i > 0
      self[product.id] = count.to_i
    else
      except! product.id
      0
    end
  end

  def total
    content.inject(0) do |total, (product, count)|
      total += product.price * count
    end
  end

  def update(hash)
    hash.each do |product, count|
      set! product, count
    end
  end
end
