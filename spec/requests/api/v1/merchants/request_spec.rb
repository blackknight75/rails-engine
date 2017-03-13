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
      expect(merchant_attrs.count).to eq(4)
    end

    it 'find merchant by id' do
      merchants = create_list(:merchant, 2)

      get "/api/v1/merchants/find?id=#{merchants.last.id}"

      merchant_attrs = JSON.parse(response.body)
      expect(response).to be_success

      expect(merchant_attrs["id"]).to eq(Merchant.last.id)
    end

    it 'find merchant by name' do
      merchants = create_list(:merchant, 2)

      get "/api/v1/merchants/find?name=#{merchants.last.name}"

      merchant_attrs = JSON.parse(response.body)
      expect(response).to be_success

      expect(merchant_attrs["name"]).to eq(Merchant.last.name)
    end

    it 'find merchant by created_date' do
      merchants = create_list(:merchant, 2)

      get "/api/v1/merchants/find?created_at=#{merchants.last.created_at}"

      merchant_attrs = JSON.parse(response.body)
      parsed_merchant_date = merchant_attrs["created_at"].to_datetime
      db_merchant = Merchant.last
      expect(response).to be_success
      expect(parsed_merchant_date.strftime("%D")).to eq(db_merchant.created_at.strftime("%D"))
    end
  end
