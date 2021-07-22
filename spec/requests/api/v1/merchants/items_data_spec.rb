require 'rails_helper'

RSpec.describe '/api/v1/merchants/:id/items' do
  it 'returns all items for a valid merchant id' do
    merchant = create(:merchant)
    other_merchant = create(:merchant)
    items = create_list(:item, 10, merchant_id: merchant.id)
    create_list(:item, 3, merchant_id: other_merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data].count).to eq(items.count)
    expect(reply[:data][0][:id]).to eq(items[0].id.to_s)
    expect(reply[:data][0][:attributes][:name]).to eq(items[0].name)
    expect(reply[:data][0][:attributes][:description]).to eq(items[0].description)
    expect(reply[:data][0][:attributes][:unit_price]).to eq(items[0].unit_price)
    expect(reply[:data][0][:attributes][:merchant_id]).to eq(items[0].merchant_id)
  end

  it 'returns 404 if merchant is not found' do
    get "/api/v1/merchants/123234/items"

    expect(response.status).to eq(404)
  end
end
