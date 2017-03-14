require 'rails_helper'

describe "Customers", type: :request do
  it 'returns all customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customers.count).to eq 3
    expect(customers.first[:first_name]).to be_a String
    expect(customers.first[:last_name]).to be_a String
  end

  it 'returns a single customer' do
    create_list(:customer, 2)

    get "/api/v1/customers/#{Customer.last.id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:first_name]).to be_a String
    expect(customer[:last_name]).to be_a String
  end

  it 'finds a single customer by attribute' do
    create_list(:customer, 2)

    get "/api/v1/customers/find?first_name=#{Customer.last.first_name}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:first_name]).to be_a String
    expect(customer[:last_name]).to be_a String
  end

  it 'finds all customers by attribute' do
    create_list(:customer, 3)

    get "/api/v1/customers/find_all?first_name=#{Customer.last.first_name}"

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customers.count).to eq 3
    expect(customers.first[:first_name]).to be_a String
    expect(customers.last[:last_name]).to be_a String
  end

  it 'finds a random customer' do
    create_list(:customer, 2)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:first_name]).to be_a String
    expect(customer[:last_name]).to be_a String
  end
end
