require 'rails_helper'

  describe 'merchants', type: :request do
    it 'return all merchants' do
      create_list(:merchant, 5)

      get '/api/v1/merchants'

      expect(response).to be_success
    end
  end
