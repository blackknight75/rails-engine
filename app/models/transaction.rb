class Transaction < ApplicationRecord
  validates :credit_card_number, :result, :invoice_id, presence: true

  belongs_to :invoice
  has_many :customers, through: :invoices
  scope :successful, -> { where(result: 'success') }
end
