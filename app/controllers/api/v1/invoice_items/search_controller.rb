class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItem.search_all(invoice_item_params)
  end

  def show
    render json: InvoiceItem.search(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at, :unit_price)
  end
end
