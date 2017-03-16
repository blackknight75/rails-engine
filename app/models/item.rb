class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

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

  def best_day
    invoices.joins(:invoice_items)
    .group(:id)
    .order("sum(invoice_items.quantity) DESC, invoices.created_at DESC")
    .first
    .created_at
  end

  def self.most_items_sold(quantity)
    select("items.*")
    .joins(invoices: [:transactions, :invoice_items])
    .merge(Transaction.successful)
    .group(:id)
    .order("count(invoice_items) DESC")
    .take(quantity)
  end
end
