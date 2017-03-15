require 'rails_helper'

describe "Transaction Relationships" do
  it 'returns an invoice for transaction' do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(invoice).to have_key :customer_id
    expect(invoice).to have_key :merchant_id
    expect(invoice).to have_key :status
  end
end
