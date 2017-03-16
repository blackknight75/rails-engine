class RevenueSerializer < ActiveModel::Serializer
  attributes :revenue

  def revenue
    (object.to_f / 100.00).to_s
  end
end
