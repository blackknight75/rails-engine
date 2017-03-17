require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:merchant_id) }
  it { should validate_presence_of(:unit_price)}
  it { should respond_to(:merchant) }
  it { should respond_to(:invoice_items) }
  it { should respond_to(:invoices) }
end
