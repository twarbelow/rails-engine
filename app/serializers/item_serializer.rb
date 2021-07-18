class ItemSerializer
  def self.render(item)
    {
      "data": {
        "id": item.id,
        "type": "item",
        "attributes": {
          "name": item.name,
          "description": item.description,
          "unit_price": item.unit_price
        }
      }
    }
  end
end
