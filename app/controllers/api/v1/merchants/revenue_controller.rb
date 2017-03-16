class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.revenue(params[:date], params[:id]), serializer: RevenueSerializer
  end
end
