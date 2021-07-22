require 'rails_helper'

RSpec.describe 'get merchant' do
  it 'returns merchant information when provided a valid id' do
    merchant = create(:merchant)
    get api_v1_merchant_path(merchant.id)

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(merchant.id.to_s)
    expect(reply[:data][:type]).to eq("merchant")
    expect(reply[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'returns 404 when provided with invalid id integer' do
    get "/api/v1/merchants/123234345"

    expect(response.status).to eq(404)
  end

  it 'returns 404 when provided with string for id' do
    get "/api/v1/merchants/these-are-words"

    expect(response.status).to eq(404)
  end
end
