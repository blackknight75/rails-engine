class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
end
