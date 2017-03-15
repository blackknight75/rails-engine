require 'rails_helper'

describe "Customer Relationships" do
  it 'returns all invoices for customer' do
    customer = create(:customer)
    create_list(:invoice, 3, customer_id: customer.id)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 3
    expect(invoices.first).to have_key :customer_id
    expect(invoices.first).to have_key :merchant_id
    expect(invoices.first).to have_key :status
  end

  it 'returns all transactions for customer' do
    customer = create(:customer)
    invoice1, invoice2, invoice3 = create_list(:invoice, 3, customer_id: customer.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions.count).to eq 3
    expect(transactions.first).to have_key :invoice_id
    expect(transactions.first).to have_key :credit_card_number
    expect(transactions.first).to have_key :result
  end
end
