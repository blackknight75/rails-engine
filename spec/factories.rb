FactoryGirl.define do
  factory :invoice do
    status "shipped"
    customer_id 1
    merchant_id 2
  end
  factory :merchant do
    name Faker::Name.name
  end
end
