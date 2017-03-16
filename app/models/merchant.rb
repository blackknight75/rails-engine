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

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('sum(invoice_items.quantity) desc')
    .limit(quantity)
  end

  def self.revenue(date = nil, id)
    return revenue_by_date(date, id) if date
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(invoices: {merchant_id: id})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.revenue_by_date(date, id)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(invoices: {created_at: date})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
