require 'rails_helper'

RSpec.describe 'Item Relationships' do
  it 'returns a collection of associated invoice_items' do
    item = create(:item)
    create_list(:invoice_item, 4, item_id: item.id)
    create(:invoice_item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.count).to eq 4
    expect(invoice_items.first).to have_key(:item_id)
    expect(invoice_items.first).to have_key(:quantity)
    expect(invoice_items.first).to have_key(:unit_price)
  end

  it 'returns associated merchant' do
    merchant = create(:merchant)
    item     = create(:item, merchant_id: merchant.id)
    create(:merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_attrs.count).to eq 2
    expect(merchant_attrs).to have_key(:name)
  end
end
