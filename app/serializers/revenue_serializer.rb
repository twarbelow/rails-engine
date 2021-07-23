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
end
