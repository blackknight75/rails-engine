require 'rails_helper'

describe "invoices", type: :request do
  it "returns all invoices" do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 5
    expect(invoices.first).to have_key(:status)
    expect(invoices.first).to have_key(:merchant_id)
    expect(invoices.first).to have_key(:customer_id)
  end

  it "returns a single invoice" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:status)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:customer_id)
  end
end
