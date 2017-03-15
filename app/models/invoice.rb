class Invoice < ApplicationRecord
  validates :customer_id, :merchant_id, :status, presence: true

  belongs_to :merchant
  belongs_to :customer

  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items
end
