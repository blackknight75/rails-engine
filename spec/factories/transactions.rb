FactoryGirl.define do
  factory :transaction do
    credit_card_number Faker::Business.credit_card_number
    result "success"
    invoice
  end
end
