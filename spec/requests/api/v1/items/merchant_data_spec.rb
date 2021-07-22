require 'rails_helper'

RSpec.describe 'get /api/v1/items/:id/merchant' do
  it 'returns the merchant associated with that item id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(merchant.id.to_s)
    expect(reply[:data][:type]).to eq("merchant")
    expect(reply[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'returns 404 if that item is not found' do
    get "/api/v1/items/123234/merchant"

    expect(response.status).to eq(404)
  end
end
