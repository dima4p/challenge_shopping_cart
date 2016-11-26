# == Schema Information
#
# Table name: products
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  price      :decimal(15, 2)
#  updated_at :datetime         not null
#

# Model Product defines the core model that represent the things to be put
# into the shopping cart
#
class Product < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}

  scope :ordered, -> { order(:name) }

end
