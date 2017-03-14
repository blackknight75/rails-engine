class InvoiceItem < ApplicationRecord
  validates :unit_price, :invoice_id, :item_id, :quantity, presence: true 
end
