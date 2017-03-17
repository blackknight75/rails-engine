require 'rails_helper'

describe "Items", type: :request do
  it "returns all items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq 3
    expect(items.first).to have_key(:name)
    expect(items.first).to have_key(:description)
  end

  it "returns a single item" do
    items = create_list(:item, 2)

    get "/api/v1/items/#{items.last.id}"

    expect(response).to be_success

    item_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(item_attrs.count).to eq 5
    expect(item_attrs).to have_key(:name)
    expect(item_attrs).to have_key(:description)
  end

  it "returns random item" do
    items = create_list(:item, 2)

    get '/api/v1/items/random'

    expect(response).to be_success

    random_item = JSON.parse(response.body, symbolize_names: true)
    expect(random_item.count).to eq 5
    expect(random_item).to have_key(:name)
    expect(random_item).to have_key(:description)
  end

  it 'returns nil when search item name not in database' do
    items  = create_list(:item, 2, unit_price: 4)
    item0  = create(:item, unit_price: 1)
    item1  = create(:item, unit_price: 1)

    get "/api/v1/items/find_all?name=khjsfdalkasdfj"

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq 0
    expect(response.body).to eq("[]")
    expect(items).to eq([])
  end

  it "returns all items based on unit_price" do
    items  = create_list(:item, 2, unit_price: 4)
    item0  = create(:item, unit_price: 1)
    item1  = create(:item, unit_price: 1)

    get "/api/v1/items/find_all?unit_price=0.01"

    expect(response).to be_success

    items_with_matching_unit_price = JSON.parse(response.body, symbolize_names: true)

    expect(items_with_matching_unit_price.count).to eq 2
    expect(items_with_matching_unit_price.first[:unit_price]).to eq("0.01")
  end

  it 'returns item -- created_at lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?created_at=#{db_item.created_at}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 5
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- updated_at lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?updated_at=#{db_item.updated_at}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 5
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it "returns a single item based on description" do
    items = create_list(:item, 10, description: "hi")
    item  = create(:item, description: "sunbeam")

    get '/api/v1/items/find?description=sunbeam'

    item_with_matching_description = JSON.parse(response.body, symbolize_names: true)

    expect(item_with_matching_description.count).to eq 5
    expect(item_with_matching_description).to have_value("sunbeam")
  end
end
