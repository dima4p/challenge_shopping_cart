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

require 'rails_helper'

describe Product, type: :model do

  subject { create :product }

  describe 'validations' do
    it { should be_valid }
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
    it {should validate_numericality_of(:price).is_greater_than_or_equal_to 0}
  end   # validations

  describe 'class methods' do
    describe 'scopes' do
      describe '.ordered' do
        it 'orders the records of Product by :name' do
          create :product
          create :product
          expect(Product.ordered).to eq Product.order(:name)
        end
      end   # .ordered
    end   # scopes
  end   # class methods

end
