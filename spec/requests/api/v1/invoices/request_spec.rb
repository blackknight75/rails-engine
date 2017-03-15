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

  it "returns single invoice" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 4
    expect(invoice_attrs).to have_key(:status)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:customer_id)
  end

  it "returns all invoices based on status lookup" do
    create_list(:invoice, 2)
    create(:invoice, status: "pending")

    get "/api/v1/invoices/find_all?status=shipped"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq 2
    expect(invoices.first).to have_value("shipped")
  end

  it "returns single invoice based on merchant_id lookup" do
    create_list(:invoice, 2)
    merchant = create(:merchant)
    create(:invoice, merchant_id: merchant.id)

    get "/api/v1/invoices/find?merchant_id=#{merchant.id}"

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq 4
    expect(invoices).to have_value("shipped")
  end

  it "returns a random invoice" do
    create_list(:invoice, 10)

    get "/api/v1/invoices/random"

    expect(response).to be_success

    random_invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(random_invoice_attrs.count).to eq 4
    expect(random_invoice_attrs).to have_key(:status)
  end
end
