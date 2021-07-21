require 'rails_helper'
RSpec.describe 'search for all merchants' do
  it 'by name' do
    merchant1 = Merchant.create!(name: "Ring")
    merchant2 = Merchant.create!(name: "ring")
    merchant3 = Merchant.create!(name: "Thing")
    Merchant.create!(name: "Horse")

    get api_v1_merchants_find_all_path(name: "ing")

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][0][:id]).to eq(merchant1.id.to_s)
    expect(reply[:data][0][:type]).to eq("merchant")
    expect(reply[:data][0][:attributes][:name]).to eq(merchant1.name)

    expect(reply[:data][1][:id]).to eq(merchant3.id.to_s)
    expect(reply[:data][1][:type]).to eq("merchant")
    expect(reply[:data][1][:attributes][:name]).to eq(merchant3.name)

    expect(reply[:data][2][:id]).to eq(merchant2.id.to_s)
    expect(reply[:data][2][:type]).to eq("merchant")
    expect(reply[:data][2][:attributes][:name]).to eq(merchant2.name)
  end
#  returns { "data": [ { "id": "4", "type": "merchant", "attributes": { "name": "Ring World" } }, { "id": "1", "type": "merchant", "attributes": { "name": "Turing School" } } ] }
  xit 'returns ampty array if no matches are found' do
    get api_v1_merchants_find_all_path(name: 'NOPE-NO-MATCHES')

    expect(response.status).to eq(404)

    expect(reply[:data][0]).to be(empty)
  end

  xit 'param cannot be empty' do
    get api_v1_merchants_find_all_path(name: '')

    expect(response.status).to eq(400)
  end

  xit 'param cannot be missing' do
    get api_v1_merchants_find_all_path()

    expect(response.status).to eq(400)
  end
end
#  the user can send ?name=ring and it will search the name field in the database table
#  the search data in the name query parameter should require the database to do a case-insensitive search for text fields
