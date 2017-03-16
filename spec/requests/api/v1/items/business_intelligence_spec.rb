require 'rails_helper'

describe 'Items Business Intelligence' do
  it "returns top ranked items by revenue" do
    setup

    get "/api/v1/items/most_revenue?quantity=2"

    expect(response).to be_success

    top_items = JSON.parse(response.body, symbolize_names: true)

    expect(top_items.count).to eq 2
  end
end

def setup
  @customer = create(:customer)
  @merchant1 = create(:merchant)
  @merchant2 = create(:merchant)
  (@item1, @item2) = create_list(:item, 2, merchant_id: @merchant1.id)
  (@item3, @item4) = create_list(:item, 2, merchant_id: @merchant2.id)
  @invoice1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant1.id)
  @invoice2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant2.id)
  @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
  @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, quantity: 100)
  @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice1.id, quantity: 2)
  @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice2.id, quantity: 5)
  @transaction1 = create(:transaction, invoice_id: @invoice1.id)
  @transaction2 = create(:transaction, invoice_id: @invoice2.id)
end
