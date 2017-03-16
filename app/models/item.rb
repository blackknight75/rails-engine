class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.search(params)
    if params.include? "unit_price"
      params[:unit_price] = (JSON.parse(params[:unit_price]).to_f * 100).round
      find_by(params)
    else
      where(params).sort.first
    end
  end

  def self.search_all(params)
    if params.include? "unit_price"
      params[:unit_price] = (JSON.parse(params[:unit_price]).to_f * 100).round
      where(params)
    else
      where(params)
    end
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("sum(invoice_items.quantity) DESC").limit(quantity)
  end
end
