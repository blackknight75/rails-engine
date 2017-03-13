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

    it 'returns single merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success

      merchant_attrs = JSON.parse(response.body, symbolize_names: true)
      expect(Merchant.last.name).to eq(merchant_attrs[:name])
      expect(merchant_attrs.count).to eq(4)
    end
  end
