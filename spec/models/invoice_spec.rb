require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "invoice validation" do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:status) }
  end
end
