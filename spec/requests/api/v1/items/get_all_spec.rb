require 'rails_helper'

RSpec.describe '/api/v1/items?per_page=<numbers>&page=<number>' do
  it 'defaults to return 20 items per page, starting on page 1' do
    items = create_list(:item, 100)

    get "/api/v1/items"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data].count).to eq(20)
    expect(reply[:data][0][:id]).to eq(items[0].id.to_s)
  end

  xit 'returns the specified number of results per page, starting on the specified page number' do

  end

  xit 'returns an empty array if there is nothing to return' do

  end

  xit 'returns an empty array if the user requests a page that does not have data' do

  end
end
# NOT include dependent data of the resource (eg, if you’re fetching merchants, do not send any data about merchant’s items or invoices)
