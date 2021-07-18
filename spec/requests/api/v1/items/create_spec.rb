require 'rails_helper'

RSpec.describe 'item creation' do
  it 'accepts json body and post to create' do
    merchant = create(:merchant)
    json_body = { "name": "new item", "description": "this is a new item", "unit_price": 1, "merchant_id": merchant.id}

    post api_v1_items_path, params: json_body

    expect(response.status).to eq(201)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply[:data][:id]).to be_an(Integer)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(json_body[:name])
    expect(reply[:data][:attributes][:description]).to eq(json_body[:description])
    expect(reply[:data][:attributes][:unit_price]).to eq(json_body[:unit_price])
    expect(reply[:data][:attributes][:merchant_id]).to eq(merchant.id)

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

  it 'returns an error if correct attributes have unexpected value types' do
    json_body = { "name": 1, "description": 5.2, "unit_price": "tacos", "merchant_id": "pickle"}

    post api_v1_items_path, params: json_body

    expect(response.status).to eq(400)
  end
end
