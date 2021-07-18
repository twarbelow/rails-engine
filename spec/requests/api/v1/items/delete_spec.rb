require 'rails_helper'

RSpec.describe 'delete item' do
  it 'destroys an item when provided a valid item id' do
    item = create(:item)

    delete "/api/v1/items/#{item.id}"

    expect(response.status).to eq(204)
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)

  end

  it 'sends 404 if the requested item id is not in the database' do
    delete "/api/v1/items/1234567890987654321"

    expect(response.status).to eq(404)
  end
  # it 'deletes associated invoices where the item is the only item on that invoice' do
  # end
end
