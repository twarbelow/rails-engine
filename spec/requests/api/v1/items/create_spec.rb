require 'rails_helper'

RSpec.describe 'item creation' do
  it 'accepts json body and post to create' do
    merchant = create(:merchant)
    json_body = { "name": "new item", "description": "this is a new item", "unit_price": 1, "merchant_id": merchant.id}

    post api_v1_items_path, params: json_body

    expect(response.status).to eq(201)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:id)
    expect(reply[:data]).to have_key(:type)
    expect(reply[:data]).to have_key(:attributes)
    expect(reply[:data][:attributes]).to have_key(:name)
    expect(reply[:data][:attributes]).to have_key(:description)
    expect(reply[:data][:attributes]).to have_key(:unit_price)
  end

  it 'ignores any extra attributes sent in the request body' do
    merchant = create(:merchant)
    json_body = { "name": "new item", "description": "this is a new item", "unit_price": 1, "merchant_id": merchant.id, "pickles": "pickles"}

    post api_v1_items_path, params: json_body

    expect(response.status).to eq(201)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to_not have_key(:pickles)
    expect(reply[:data]).to_not have_key(:pickles)
    expect(reply[:data][:attributes]).to_not have_key(:pickles)
  end

  it 'returns an error if an expected attribute is missing from the request body' do
    merchant = create(:merchant)
    json_body = { "name": "new item", "unit_price": 1, "merchant_id": merchant.id}

    post api_v1_items_path, params: json_body
    
    expect(response.status).to eq(400)
  end
end
