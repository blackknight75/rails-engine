require 'rails_helper'

describe 'Merchant Business Intelligence' do
  it 'returns favorite customer by number of interactions' do
    merchant = create(:merchant)
    (customer1, customer2) = create_list(:customer, 2)
    invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
    invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
    invoice3 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success

    favorite_customer = JSON.parse(response.body, symbolize_names: true)
    expect(favorite_customer[:first_name]).to eq(customer2.first_name)
  end
end
