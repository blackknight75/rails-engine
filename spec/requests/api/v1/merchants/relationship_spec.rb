require 'rails_helper'

describe 'Merchant Relationships' do
  it 'returns items associated with a merchant' do
    merchant = create(:merchant)
    (item1, item2, item3) = create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items.count).to eq 3
    # expect(items).to eq([item1, item2, item3])
    expect(items.first).to have_key :name
    expect(items.first).to have_key :unit_price
    expect(items.first).to have_key :description
  end

  it 'returns invoices associated with a merchant' do
    merchant = create(:merchant)
    (invoice1, invoice2) = create_list(:invoice, 2, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 2
    expect(invoices.first).to have_key :customer_id
    expect(invoices.first).to have_key :merchant_id
    expect(invoices.first).to have_key :status
  end
end
