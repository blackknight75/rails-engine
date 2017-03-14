require 'rails_helper'

describe "items", type: :request do
  it "returns all items" do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq 10
    expect(items.first).to have_key(:name)
    expect(items.first).to have_key(:description)
  end

  it "returns a single item" do
    items = create_list(:item, 10)

    get "/api/v1/items/#{items.last.id}"

    expect(response).to be_success

    item_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(item_attrs.count).to eq 7
    expect(item_attrs).to have_key(:name)
    expect(item_attrs).to have_key(:description)
  end

  it "returns random item" do
    items = create_list(:item, 10)

    get '/api/v1/items/random'

    expect(response).to be_success

    random_item = JSON.parse(response.body, symbolize_names: true)
    expect(random_item.count).to eq 7
    expect(random_item).to have_key(:name)
    expect(random_item).to have_key(:description)
  end

  it "returns all items based on unit_price" do
    items  = create_list(:item, 2)
    item0  = create(:item, unit_price: 12)
    item1  = create(:item, unit_price: 12)
    get "/api/v1/items/find_all?unit_price=12"

    expect(response).to be_success

    items_with_matching_unit_price = JSON.parse(response.body, symbolize_names: true)

    expect(items_with_matching_unit_price.count).to eq 2
    expect(items_with_matching_unit_price.first).to have_value(12)
  end

  it "returns a single item based on description" do
    items = create_list(:item, 10, description: "hi")
    item  = create(:item, description: "sunbeam")

    get '/api/v1/items/find?description=sunbeam'

    item_with_matching_description = JSON.parse(response.body, symbolize_names: true)

    expect(item_with_matching_description.count).to eq 7
    expect(item_with_matching_description).to have_value("sunbeam")
  end
end
