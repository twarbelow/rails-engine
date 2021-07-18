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

  it 'deletes associated invoices where the item is the only item on that invoice' do
    item1 = create(:item)
    item2 = create(:item)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1)
    InvoiceItem.create!(item_id: item2.id, invoice_id: invoice1.id, quantity: 1, unit_price: 1)
    InvoiceItem.create!(item_id: item1.id, invoice_id: invoice2.id, quantity: 1, unit_price: 1)

    delete "/api/v1/items/#{item1.id}"

    expect(response.status).to eq(204)

    expect{Invoice.find(invoice2.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
