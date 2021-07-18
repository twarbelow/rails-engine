require 'rails_helper'

RSpec.describe 'update item' do
  it 'with valid id and valid attributes' do
    item = create(:item)
    json_body = { "name": "item update", "description": "this is an updated item", "unit_price": 1}

    patch api_v1_item_path(item.id), params: json_body

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply[:data][:id]).to be_an(Integer)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(json_body[:name])
    expect(reply[:data][:attributes][:description]).to eq(json_body[:description])
    expect(reply[:data][:attributes][:unit_price]).to eq(json_body[:unit_price])
    expect(reply[:data][:attributes][:merchant_id]).to eq(item[:merchant_id])

  end
  # it 'returns an error if the id is not valid' do
  # end
  # it 'returns an error if there are no valid attributes' do
  # end
  # it 'returns an error if one or more of the attributes has invalid value' do
  # end
end
