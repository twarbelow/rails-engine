require 'rails_helper'

RSpec.describe 'delete item' do
  it 'destroys an item when provided a valid item id' do
    item = create(:item)

    DELETE "api/v1/items/#{item.id}"

    expect(response.status).to eq(204)

    expect(item).to be(nil)

    expect(response.body).to eq(nil)
  end

  it 'deletes associated invoices where the item is the only item on that invoice' do
  end
end
