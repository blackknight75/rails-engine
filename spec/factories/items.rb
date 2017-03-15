FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Hipster.sentence
    unit_price 1
    merchant
  end
end
