FactoryGirl.define do
  factory :invoice_item do
    item_id 1
    invoice_id 1
    quantity 1
    unit_price 1
  end
  factory :item do
    name Faker::Name.name
    description Faker::Lorem.sentence
    unit_price 1
    merchant_id 1
  end
  factory :invoice do
    status "shipped"
    customer_id 1
    merchant_id 2
  end
  factory :merchant do
    name Faker::Name.name
  end
end
