class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customer
    customers.joins(:transactions)
    .merge(Transaction.successful)
    .group(:id).order('count(transactions) DESC').first
  end

  def self.most_revenue(number_of_returns)
    joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group(:id).order("sum(quantity * unit_price) DESC")
    .limit(number_of_returns)
  end
end
