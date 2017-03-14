require 'rails_helper'

describe 'Transactions', type: :request do
  it 'returns all transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body, symoblize_names: true)

    expect(transactions.count).to eq 3
    expect(transactions.first).to have_key("result")
    expect(transactions.first).to have_key("credit_card_number")
  end

  it 'returns a single transactions' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symoblize_names: true)
    expect(transaction).to have_key("result")
    expect(transaction).to have_key("credit_card_number")
  end

  it 'finds a single item by attribute' do
    transactions = create_list(:transaction, 2)

    get "/api/v1/transactions/find?credit_card_number=#{transactions.first.credit_card_number}"

    expect(response).to be_success
    transaction = JSON.parse(response.body,  symbolize_names: true)
    # binding.pry
    expect(transaction[:credit_card_number]).to eq(transactions.first["credit_card_number"])
  end
end
