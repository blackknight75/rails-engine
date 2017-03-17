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

  it 'returns a single transaction' do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symoblize_names: true)
    expect(transaction).to have_key("result")
    expect(transaction).to have_key("credit_card_number")
  end

  it 'finds a single transaction -- cc lookup' do
    transactions = create_list(:transaction, 2)

    get "/api/v1/transactions/find?credit_card_number=#{transactions.first.credit_card_number}"

    expect(response).to be_success
    transaction = JSON.parse(response.body,  symbolize_names: true)
    expect(transaction[:credit_card_number]).to eq(transactions.first["credit_card_number"])
  end

  it 'returns transaction -- created_at lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{db_transaction.created_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 4
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns transaction -- updated_at lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{db_transaction.updated_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 4
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end


  it 'finds all transactions by attribute' do
    transaction1 = create(:transaction)
    transaction2 = create(:transaction, credit_card_number: 5555-2121-5555-1211)

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction1.credit_card_number}"

    expect(response).to be_success
    parsed_transactions = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_transactions.count).to eq 1
    expect(parsed_transactions.first[:credit_card_number]).to be_a String
  end

  it 'return a random transaction' do
    transaction = create_list(:transaction, 2)

    get "/api/v1/transactions/random"

    expect(response).to be_success
    parsed_transaction = JSON.parse(response.body,  symbolize_names: true)

    expect(parsed_transaction[:credit_card_number]).to be_a String
  end
end
