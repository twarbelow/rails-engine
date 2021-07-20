class ItemSerializer
  def self.render(item)
    {
      "data": {
        "id": item.id.to_s,
        "type": "item",
        "attributes": {
          "name": item.name,
          "description": item.description,
          "unit_price": item.unit_price,
          "merchant_id": item.merchant_id
        }
      }
    }
  end
end
