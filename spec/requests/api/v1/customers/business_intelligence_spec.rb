require 'rails_helper'

RSpec.describe 'Customer Business Intelligence' do
   it 'returns a merchant where the customer has conducted the most successful transactions' do
     customer = create(:customer, id: 1)

     least_fav_merchant = create(:merchant)
     most_fav_merchant  = create(:merchant, name: 'John')

     least_fav_merchant.invoices << create(:invoice, customer_id: 1)
     most_fav_merchant.invoices << create_list(:invoice, 2, customer_id: 1)

     least_fav_merchant.invoices.each {|i| i.transactions << create(:transaction, result: 'success')}
     most_fav_merchant.invoices.each {|i| i.transactions << create(:transaction, result: 'success')}

     get "/api/v1/customers/1/favorite_merchant"

     expect(response).to be_success

     fav_merchant = JSON.parse(response.body)

     expect(fav_merchant).to have_value('John')
   end
end
