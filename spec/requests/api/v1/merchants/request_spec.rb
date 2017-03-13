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
  end
