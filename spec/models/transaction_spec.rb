require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of(:result) }
  it { should validate_presence_of(:invoice_id) }
  it { should validate_presence_of(:credit_card_number) }
  it { should respond_to(:invoice) }
end
