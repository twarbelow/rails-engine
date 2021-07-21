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

  def self.render_empty
    {
      "data": {
        "id": nil,
        "type": "item",
        "attributes": {
          "name": nil,
          "description": nil,
          "unit_price": nil,
          "merchant_id": nil
        }
      }
    }
  end
end
