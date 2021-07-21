class MerchantSerializer
  def self.render(merchant)
    {
      "data": {
        "id": merchant.id.to_s,
        "type": "merchant",
        "attributes": {
          "name": merchant.name
        }
      }
    }
  end
end
