FactoryGirl.define do
  factory :invoice_item do
    quantity 1
    unit_price Faker::Commerce.price
    invoice
    item
  end
end
