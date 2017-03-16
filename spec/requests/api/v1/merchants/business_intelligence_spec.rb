require 'rails_helper'

describe 'Merchant Business Intelligence' do

  it 'by default, returns top 2 merchants based on number of items sold' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant, name: "Tim")
    merchant_3 = create(:merchant, name: "John")

    merchant_1.invoices << create_list(:invoice, 2)
    merchant_2.invoices << create_list(:invoice, 2)
    merchant_3.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 10)
      invoice.invoice_items << create(:invoice_item, quantity: 20)
    end

    merchant_2.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 30)
      invoice.invoice_items << create(:invoice_item, quantity: 40)
    end

    merchant_3.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 50)
      invoice.invoice_items << create(:invoice_item, quantity: 60)
    end

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_success

    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants.count).to eq 2
    expect(top_merchants.first).to have_value('John')
    expect(top_merchants.last).to have_value('Tim')
  end

  it 'returns total revenue for merchant across all transactions' do
    merchant_1 = create(:merchant)

    merchant_1.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
    end

    get "/api/v1/merchants/#{merchant_1.id}/revenue"

    expect(response).to be_success
    expect(response.body).to eq '{"revenue":"0.2"}'
  end

  it 'returns total revenue for merchant for specific invoice date' do
    merchant_1 = create(:merchant)

    merchant_1.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
    end

    get "/api/v1/merchants/#{merchant_1.id}/revenue?date=#{merchant_1.invoices.first.created_at}"

    expect(response).to be_success
    expect(response.body).to eq '{"revenue":"0.2"}'
  end
  
  it 'returns favorite customer by number of interactions' do
    merchant = create(:merchant)
    (customer1, customer2) = create_list(:customer, 2)
    invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer1.id)
    invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
    invoice3 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id)
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)
    transaction3 = create(:transaction, invoice_id: invoice3.id)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success

    favorite_customer = JSON.parse(response.body, symbolize_names: true)
    expect(favorite_customer[:first_name]).to eq(customer2.first_name)
  end

  it "returns most revenue by merchant" do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    (item1, item2) = create_list(:item, 2, merchant_id: merchant1.id)
    (item3, item4) = create_list(:item, 2, merchant_id: merchant2.id)
    invoice1 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
    invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant1.id)
    invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id)
    invoice_item2 = create(:invoice_item, item_id: item2.id, invoice_id: invoice1.id, quantity: 100)
    invoice_item3 = create(:invoice_item, item_id: item3.id, invoice_id: invoice1.id, quantity: 2)
    invoice_item4 = create(:invoice_item, item_id: item4.id, invoice_id: invoice2.id, quantity: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id)
    transaction2 = create(:transaction, invoice_id: invoice2.id)

    get "/api/v1/merchants/most_revenue?quantity=2"

    expect(response).to be_success

    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants.count).to eq 2
    expect(top_merchants.first[:name]).to eq merchant2.name
  end
end
