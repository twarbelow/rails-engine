require 'rails_helper'

RSpec.describe 'search for an item' do
  it 'can search by name' do
    merchant = create(:merchant)
    item1 = Item.create!(name: "Ring", description: "Thing that's round", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "ring", description: "lower case thing that's round", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Thing", description: "bring the things", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Rocking Horse", description: "certainly not uninspiring", unit_price: 10 , merchant_id: merchant.id )

    get api_v1_items_find_path(name: "ring")

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item1.id.to_s)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item1.name)
    expect(reply[:data][:attributes][:description]).to eq(item1.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)
  end

  it 'can search by min price' do
    merchant = create(:merchant)
    item1 = Item.create!(name: "Ring", description: "Thing that's round", unit_price: 100 , merchant_id: merchant.id )
    Item.create!(name: "ring", description: "lower case thing that's round", unit_price: 20 , merchant_id: merchant.id )
    Item.create!(name: "Thing", description: "bring the things", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Rocking Horse", description: "certainly not uninspiring", unit_price: 10 , merchant_id: merchant.id )

    get "/api/v1/items/find?min_price=50"

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item1.id.to_s)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item1.name)
    expect(reply[:data][:attributes][:description]).to eq(item1.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)
  end

  it 'can search by max price' do
    merchant = create(:merchant)
    item1 = Item.create!(name: "Ring", description: "Thing that's round", unit_price: 100 , merchant_id: merchant.id )
    Item.create!(name: "ring", description: "lower case thing that's round", unit_price: 20 , merchant_id: merchant.id )
    Item.create!(name: "Thing", description: "bring the things", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Rocking Horse", description: "certainly not uninspiring", unit_price: 10 , merchant_id: merchant.id )

    get "/api/v1/items/find?max_price=150"

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item1.id.to_s)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item1.name)
    expect(reply[:data][:attributes][:description]).to eq(item1.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)
  end

  it 'can search by min and max price' do
    merchant = create(:merchant)
    item1 = Item.create!(name: "Ring", description: "Thing that's round", unit_price: 100 , merchant_id: merchant.id )
    Item.create!(name: "ring", description: "lower case thing that's round", unit_price: 80 , merchant_id: merchant.id )
    Item.create!(name: "Thing", description: "bring the things", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Rocking Horse", description: "certainly not uninspiring", unit_price: 70 , merchant_id: merchant.id )

    get "/api/v1/items/find?max_price=150&min_price=50"

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item1.id.to_s)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item1.name)
    expect(reply[:data][:attributes][:description]).to eq(item1.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)

  end

  it 'returns an empty response if zero items match the search' do
    get "/api/v1/items/find?max_price=0"

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(response.status).to eq(404)

    expect(reply[:data][:id]).to eq(nil)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(nil)
    expect(reply[:data][:attributes][:description]).to eq(nil)
    expect(reply[:data][:attributes][:unit_price]).to eq(nil)
    expect(reply[:data][:attributes][:merchant_id]).to eq(nil)

  end
  
  it 'cannot search by name and price' do
    get "/api/v1/items/find?name=ring&min_price=50"

    expect(response.status).to eq(400)
  end

  it 'cannot respond to invalid params' do
    get "/api/v1/items/find?pandas=ring&cats=1000"

    expect(response.status).to eq(400)
  end
end
