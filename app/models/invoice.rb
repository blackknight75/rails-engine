class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true 
end
