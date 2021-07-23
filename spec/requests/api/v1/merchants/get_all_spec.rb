require 'rails_helper'

RSpec.describe '/api/v1/merchants?per_page=<numbers>&page=<number>' do
  it 'defaults to return 20 merchants per page, starting on page 1' do
    merchants = create_list(:item, 100)

    get "/api/v1/merchants"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data].count).to eq(20)
    expect(reply[:data][0][:id]).to eq(merchants[0].id.to_s)
  end

  it 'returns the specified number of results per page, starting on the specified page number' do
    merchants = create_list(:item, 6)

    get "/api/v1/merchants?per_page=5&page=2"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][0][:id]).to eq(merchants.last.id.to_s)
  end

  it 'returns an empty array if there is nothing to return' do
    get "/api/v1/merchants"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data]).to match_array([])
  end

  it 'returns an empty array if the user requests a page that does not have data' do
    create_list(:item, 10)

    get "/api/v1/merchants?per_page=10&page=1000"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data]).to match_array([])
  end
end
