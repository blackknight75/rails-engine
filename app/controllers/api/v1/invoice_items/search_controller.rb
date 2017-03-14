class Api::V1::InvoiceItems::SearchController < ApplicationController
  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

  def invoice_item_params
    params[:unit_price] = ((params[:unit_price].to_f)*100).round if params[:unit_price] && params[:unit_price].include?('.')
    params.permit(:id, :item_id, :invoice_id, :quantity, :created_at, :updated_at, :unit_price)
  end
end
