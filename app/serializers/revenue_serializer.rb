class RevenueSerializer
  def self.merchant_total(id, revenue)
    {
      "data": {
        "id": "#{id}",
        "type": "merchant_revenue",
        "attributes": {
          "revenue": revenue
        }
      }
    }
  end
end
