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

FactoryGirl.define do
  factory :product do
    sequence(:name) {|n| "Name#{format "%02d", n}" }
    sequence(:price) {|n| "15.#{format "%02d", n}".to_d }
  end
end
