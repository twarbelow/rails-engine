require 'rails_helper'

RSpec.describe '/api/v1/merchants/:id/items' do
  it 'returns all items for a valid merchant id' do
    merchant = create(:merchant)
    other_merchant = create(:merchant)
    items = create_list(:items, 10, merchant_id: merchant.id)
    create_list(:items, 3, merchant_id: other_merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response.status).to eq(200)

    expect(reply[:data].count).to eq(items.count)

    reply[:data].each do |item|
      expect(item).to have_keys(:id, :type, :attributes)
      expect(item.keys).to_not be(nil)
    end
  end
  it 'returns 404 if merchant is not found' do
    get "/api/v1/items/123234/merchant"

    expect(response.status).to eq(404)
  end
end
