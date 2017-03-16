class TotalRevenueSerializer < ActiveModel::Serializer
  attributes :total_revenue

  def total_revenue
    (object.to_f / 100.00).to_s
  end
end
