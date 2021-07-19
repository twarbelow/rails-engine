require 'rails_helper'

RSpec.describe 'get one item' do
  it 'returns item information when provided a valid id' do
    item = create(:item)
    get "/api/v1/item/#{item.id}"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item.id)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item.name)
    expect(reply[:data][:attributes][:description]).to eq(item.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'returns 404 when provided with invalid id integer' do
    get "/api/v1/item/123234345"

    expect(response.status).to eq(404)
  end

  it 'returns 404 when provided with string for id' do
    get "/api/v1/item/these-are-words"

    expect(response.status).to eq(404)
  end
end


# GET /api/v1/items/:id
# return { “data”: { “id”: “16”, “type”: “item”, attributes”: { “name”: “New Widget”, “description”: “High quality widget”, “unit_price”: 200.99}}}
# return 404 not found if that id doesn't exist
