require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "invoice validation" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:status) }
    it { should respond_to(:customer) }
    it { should respond_to(:merchant) }
    it { should respond_to(:transactions) }
    it { should respond_to(:invoice_items) }
    it { should respond_to(:items) }
  end
end
