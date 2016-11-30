require 'rails_helper'

describe ShoppingCart, type: :model do

  subject {ShoppingCart.new}

  describe 'validations' do
    it { should be_valid }
  end   # validations

  describe '#[]' do
    let (:product) {create :product}

    it 'asways returns an Integer' do
      expect(subject[99]).to be 0
    end

    it 'accepts a Product and returns the count of it' do
      subject.add! product, 4
      expect(subject[product]).to be 4
    end

    it 'accepts a Number and returns the count of the Product with this ID' do
      subject.add! product, 4
      expect(subject[product.id]).to be 4
    end
  end   #[]

  describe '#add!' do
    let!(:product) {create :product}
    let(:argument1) {product}

    context 'when the first argument is the unexisting ID for Product' do
      let(:argument1) {product.id + 1}

      it 'raises ActiveRecord::RecordNotFound' do
        expect{subject.add! argument1}.to raise_error ActiveRecord::RecordNotFound
      end
    end   # when first argument is the unexisting ID for Product

    context 'when the first argument is the ID of an existing Product' do
      let(:argument1) {product.id}

      it 'ensures it to the cart' do
        subject.add! argument1
        expect(subject.keys).to include product.id
      end

      it 'returns the cart' do
        expect(subject.update({})).to be_a ShoppingCart
      end
    end   # when the first argument is the ID of an existing Product

    context 'when the first argument is a Product' do
      it 'ensures it to the cart' do
        subject.add! argument1
        expect(subject.keys).to include product.id
      end
    end   # when the first argument is a Product

    context 'when the product was not present' do
      it 'increases the size of the cart' do
        expect{subject.add! argument1}.to change(subject, :size).by 1
      end
    end   # when the product was not present

    context 'when the product was present' do
      before :each do
        subject.add! product
      end

      it 'does not change the size of the cart' do
        expect{subject.add! argument1}.not_to change(subject, :size)
      end

      context 'when the second argument is missing' do
        it 'increases the count of the product in the cart by 1' do
          expect{subject.add! argument1}.to change{subject[product.id]}.by 1
        end
      end   # when the second argument is missing

      context 'when the second argument is blank' do
        it 'increases the count of the product in the cart by 1' do
          expect{subject.add! argument1, ''}.to change{subject[product.id]}.by 1
        end
      end   # when the second argument is blank

      context 'when the second argument is a number' do
        it 'increases the count of the product in the cart by this number' do
          expect{subject.add! argument1, 2.5}.to change{subject[product.id]}.by 2
        end
      end   # when the second argument is a number

      context 'when the second argument is a a String' do
        it 'increases the count of the product in the cart by the integer from it' do
          expect{subject.add! argument1, '3'}.to change{subject[product.id]}.by 3
        end
      end   # when the second argument is a a String
    end   # when the product was present
  end   #add!

  describe '#content' do
    context 'when empty' do
      it 'returns an empty Array' do
        expect(subject.content).to eq []
      end
    end   # when empty

    context 'when not empty' do
      let(:product1) {create :product, name: 'Product 1'}
      let(:product2) {create :product, name: 'Product 2'}
      let(:product3) {create :product, name: 'Product 3'}

      subject do
        cart = ShoppingCart.new
        cart[product2.id] = 1
        cart[product1.id] = 2
        cart[product3.id] = 0
        cart
      end

      it 'returns an Array of pairs with a Product and its amount with only positive amounts sorted' do
        expect(subject.content).to be_an Array
        expect(subject.content.size).to be 2
        expect(subject.content.first.first).to eq product1
      end
    end   # when not empty
  end   #content

  describe '#drop!' do
    let!(:product) {create :product}
    let(:argument1) {product}

    before :each do
      subject.add! product
    end

    it 'returns the cart' do
      expect(subject.drop! argument1).to be_a ShoppingCart
    end

    context 'when the argument is the unexisting ID for Product' do
      let(:argument1) {product.id + 1}

      it 'raises ActiveRecord::RecordNotFound' do
        expect{subject.drop! argument1}.to raise_error ActiveRecord::RecordNotFound
      end
    end   # when argument is the unexisting ID for Product

    context 'when the argument is the ID of an existing Product' do
      let(:argument1) {product.id}

      it 'removes it completely from the cart' do
        expect{subject.drop! argument1}.to change(subject, :size).by -1
      end
    end   # when the argument is the ID of an existing Product

    context 'when the argument is a Product' do
      it 'removes it completely from the cart' do
        expect{subject.drop! argument1}.to change(subject, :size).by -1
      end
    end   # when the argument is a Product
  end   #drop!

  describe '#set!' do
    let!(:product) {create :product}
    let(:argument1) {product}
    let(:argument2) {5}

    it 'returns the cart' do
      expect(subject.set! argument1, argument2).to be_a ShoppingCart
    end

    context 'when the first argument is the unexisting ID for Product' do
      let(:argument1) {product.id + 1}

      it 'raises ActiveRecord::RecordNotFound' do
        expect{subject.set! argument1, argument2}.to raise_error ActiveRecord::RecordNotFound
      end
    end   # when first argument is the unexisting ID for Product

    context 'when the first argument is the ID of an existing Product' do
      let(:argument1) {product.id}

      it 'ensures it to the cart' do
        subject.set! argument1, argument2
        expect(subject.keys).to include product.id
      end
    end   # when the first argument is the ID of an existing Product

    context 'when the first argument is a Product' do
      it 'ensures it to the cart' do
        subject.set! argument1, 1
        expect(subject.keys).to include product.id
      end
    end   # when the first argument is a Product

    context 'when the product was not present' do
      it 'increases the size of the cart' do
        expect{subject.set! argument1, argument2}.to change(subject, :size).by 1
      end
    end   # when the product was not present

    context 'when the product was present' do
      before :each do
        subject.set! product, 1
      end

      context 'when the second argument is a number' do
        context 'when it is positive' do
          it 'does not change the size of the cart' do
            expect{subject.set! argument1, argument2}.not_to change(subject, :size)
          end

          it 'changes the count of the product in the cart to this number' do
            expect{subject.set! argument1, 5.5}.to change{subject[product.id]}.by 4
          end
        end   # when it is positive

        context 'when it is zero' do
          let(:argument2) {0}

          it 'removes the product form the cart completely' do
            expect{subject.set! argument1, argument2}.to change(subject, :size).by -1
          end
        end   # when it is zero

        context 'when it is negative' do
          let(:argument2) {-5}

          it 'removes the product form the cart completely' do
            expect{subject.set! argument1, argument2}.to change(subject, :size).by -1
          end
        end   # when it is negative
      end   # when the second argument is a number

      context 'when the second argument is a a String' do
        it 'changes the count of the product in the cart to the integer from it' do
          expect{subject.set! argument1, '3'}.to change{subject[product.id]}.by 2
        end
      end   # when the second argument is a a String
    end   # when the product was present
  end   #set!

  describe '#total' do
    let!(:product1) {create :product, price: 5}
    let!(:product2) {create :product, price: 7}

    it 'returns the total cost of the cart' do
      subject.update product1  => '2', product2 => 1
      expect(subject.total).to eq 17.0
    end
  end   #total

  describe '#update' do
    let(:product1) {create :product}
    let(:product2) {create :product}

    it 'calls #set! for each pair of [key, value] of the incoming hash' do
      expect(subject).to receive(:set!).with(product1, 1)
      expect(subject).to receive(:set!).with(product2.id, 0)
      subject.update product1 => 1, product2.id => 0
    end

    it 'returns the cart' do
      expect(subject.update({})).to be_a ShoppingCart
    end
  end   #update
end
