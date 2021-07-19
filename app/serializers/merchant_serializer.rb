class MerchantSerializer
  def self.render(merchant)
    {
      "data": {
        "id": merchant.id,
        "type": "merchant",
        "attributes": {
          "name": merchant.name
        }
      }
    }
  end
end
