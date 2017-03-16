require 'rails_helper'

  describe 'merchants', type: :request do
    it 'return all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_success

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(5)
      expect(merchants.first).to have_key(:name)
    end

    it 'return a single merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success

      merchant_attrs = JSON.parse(response.body, symbolize_names: true)
      expect(Merchant.last.name).to eq(merchant_attrs[:name])
      expect(merchant_attrs.count).to eq(2)
    end

    it 'find merchant by id' do
      merchants = create_list(:merchant, 2)

      get "/api/v1/merchants/find?id=#{merchants.last.id}"

      merchant_attrs = JSON.parse(response.body)
      expect(response).to be_success

      expect(merchant_attrs["id"]).to eq(Merchant.last.id)
    end

    it 'returns merchant -- created_at lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{db_merchant.created_at}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 2
    expect(Merchant.count).to eq 1
  end

  it 'returns merchant -- updated_at lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{db_merchant.created_at}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 2
    expect(Merchant.count).to eq 1
  end

    it 'find merchant by name' do
      merchants = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchants.last.name}"

      merchant_attrs = JSON.parse(response.body)
      expect(response).to be_success

      expect(merchant_attrs["name"]).to eq(Merchant.last.name)
    end

    it 'find all merchants by name' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find_all?name=#{merchants.first.name}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants).to be_a(Array)
      expect(merchants.first["name"]).to eq(merchants.last["name"])
    end

    it 'returns a single random merchant' do
      merchants = create_list(:merchant, 3)

      get "/api/v1/merchants/random"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to be_a(Integer)
      expect(merchant["name"]).to be_a(String)
    end

  end
