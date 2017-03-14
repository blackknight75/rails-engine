class Api::V1::Items::SearchController < ApplicationController
  def index
    render json: Item.where(item_params)
  end

  def show
    render json: Item.find_by(item_params)
  end

  private

  def item_params
    params.permit(:id, :description, :name, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
