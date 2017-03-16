class Api::V1::Merchants::RevenueByDateController < ApplicationController

  def index
    render json: Merchant.all_merchant_revenue(params[:date]), serializer: TotalRevenueSerializer
  end
end
