class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true
  # belongs_to :item
  # belongs_to :invoice
end
