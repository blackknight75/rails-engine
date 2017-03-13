require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "merchant validation" do
    it { should validate_presence_of(:name) }
  end
end
