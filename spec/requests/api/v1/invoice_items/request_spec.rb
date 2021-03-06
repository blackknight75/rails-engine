require 'rails_helper'

describe "invoice_items" do
  it "returns all invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.count).to eq 3
    expect(invoice_items.first).to have_key(:invoice_id)
    expect(invoice_items.first).to have_key(:quantity)
  end

  it "try to return all invoice_items with nothing in database" do

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.first).to eq(nil)
    expect(response.body).to eq("[]")
  end

  it "returns a single invoice_item" do
    iis = create_list(:invoice_item, 2)

    get "/api/v1/invoice_items/#{iis.last.id}"

    expect(response).to be_success

    ii_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(ii_attrs.count).to eq 5
    expect(ii_attrs).to have_key(:quantity)
    expect(ii_attrs).to have_key(:item_id)
  end

  it "returns a random invoice_item" do
    iis = create_list(:invoice_item, 2)

    get '/api/v1/invoice_items/random'

    expect(response).to be_success

    ii_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(ii_attrs.count).to eq 5
    expect(ii_attrs).to have_key(:quantity)
    expect(ii_attrs).to have_key(:item_id)
  end

  it "returns all invoice_items based on criteria" do
    iis_generic  = create_list(:invoice_item, 2, quantity: 4)
    iis_relevant = create_list(:invoice_item, 3, quantity: 2)

    get '/api/v1/invoice_items/find_all?quantity=2'

    expect(response).to be_success

    iis_match = JSON.parse(response.body, symbolize_names: true)

    expect(iis_match.count).to eq 3
    expect(iis_match.first).to have_key(:invoice_id)
    expect(iis_match.first).to have_key(:quantity)
  end

  it "returns a single invoice_item based on item id " do
    iis = create_list(:invoice_item, 2)
    item = create(:item)
    ii  = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/find?item_id=#{item.id}"

    expect(response).to be_success

    ii_match = JSON.parse(response.body, symbolize_names: true)

    expect(ii_match.count).to eq 5
    expect(ii_match).to have_value(item.id)
  end

  it 'can search all invoice_items by quantity' do
    invoice_items = create_list(:invoice_item, 3, quantity: 5)

    expect(InvoiceItem.search_all(quantity: 5).count).to eq 3
  end

  it 'can search for single merchant item by quantity' do
    invoice_items = create_list(:invoice_item, 2, quantity: 3)
    invoice_items = create(:invoice_item, quantity: 5)

    expect(InvoiceItem.search(quantity: 5).quantity).to eq 5
  end
end
