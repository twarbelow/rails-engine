class RevenueSerializer
  def self.merchant_total(id, revenue)
    {
      "data": {
        "id": id.to_s,
        "type": 'merchant_revenue',
        "attributes": {
          "revenue": revenue
        }
      }
    }
  end

  def self.unshipped_revenue(things)
    {
      "data": things.map do |thing|
        {
          "id": thing.id.to_s,
          "type": 'unshipped_order',
          "attributes": {
            "potential_revenue": thing.revenue,
          }
        }
      end
    }
  end
end
