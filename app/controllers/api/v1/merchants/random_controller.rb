class Api::V1::Merchants::RandomController <ApplicationController

  def show
    render json: random_record(Merchant.all)
  end
end
