require 'rails_helper'

RSpec.describe 'item creation' do
  it 'accepts json body and post to create' do
    merchant = create(:merchant)
    json_body = { "name": "new item", "description": "this is a new item", "unit_price": 1, "merchant_id": merchant.id}

    post api_v1_items_path, params: json_body

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body)

  end
end
