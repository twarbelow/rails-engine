require 'rails_helper'

RSpec.describe 'search for an item' do
  it 'can search by name' do
    merchant = create(:merchant)
    item1 = Item.create!(name: "Ring", description: "Thing that's round", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "ring", description: "lower case thing that's round", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Thing", description: "bring the things", unit_price: 10 , merchant_id: merchant.id )
    Item.create!(name: "Rocking Horse", description: "certainly not uninspiring", unit_price: 10 , merchant_id: merchant.id )

    get "/api/v1/items/find?name=ring"
    # get api_v1_items_find_path(name: "ring")

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(item1.id.to_s)
    expect(reply[:data][:type]).to eq("item")
    expect(reply[:data][:attributes][:name]).to eq(item1.name)
    expect(reply[:data][:attributes][:description]).to eq(item1.description)
    expect(reply[:data][:attributes][:unit_price]).to eq(item1.unit_price)
    expect(reply[:data][:attributes][:merchant_id]).to eq(item1.merchant_id)


    # results should be in case-sensitive alphabetical order
    # the search data in the merchant_id query parameter should require the database to do a case-insensitive search for text fields (names and descriptions!)
  end

  # it 'can search by min price' do
  #   get "/api/v1/items/find?min_price=50"
  # end
  #
  # it 'can search by max price' do
  #   get "/api/v1/items/find?max_price=150"
  # end
  #
  # it 'can search by min and max price' do
  #   get "/api/v1/items/find?max_price=150&min_price=50"
  # end
  #
  # it 'returns an empty response if zero items match the search'
  #   get "/api/v1/items/find?max_price=0"
  #
  # it 'cannot search by name and price' do
  #   get "/api/v1/items/find?name=ring&min_price=50"
  # end
end

# results should be in case-sensitive alphabetical order
# the search data in the name query parameter should require the database to do a case-insensitive search for text fields (names and descriptions!)
# allow the user to send one or more price-related query parameters, both min_price and max_price can be sent
# the user may send EITHER the name parameter OR either/both of the price parameters; users should get an error if name and either/both of the price parameters are sent
# respond with { "data": [ { "id": "4", "type": "item", "attributes": { REGULAR ITEM ATTRIBUTES } }, { "id": "1", "type": "item", "attributes": { REGULAR ITEM ATTRIBUTES } } ] }
# JSON response will always be an array of objects, even if zero matches or only one match is found.
# should not return a 404 if no matches are found.
