require 'rails_helper'

RSpec.describe 'single merchant revenue' do
  it 'gets the total revenue for a single merchant when provided with a valid id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)

    invoice_success1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_id, status: "shipped")
    invoice_success2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_id, status: "shipped")
    invoice_fail1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant_id, status: "failure")

    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_success1.id, quantity: 100, unit_price: 1.0)
    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_success2.id, quantity: 100, unit_price: 1.0)
    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_fail1.id, quantity: 100, unit_price: 1.0)

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expect(response.status).to eq(200)

    reply = JSON.parse(response, symbolize_names: true)

    expect(reply[:data][:id]).to eq(merchant.id)
    expect(reply[:data][:type]).to eq("merchant_revenue")
    expect(reply[:data][:attributes][:revenue]).to eq(200)
  end
  # no merchant with that id
  # any other sad/edge?
end
# {
#   "data": {
#     "id": "42",
#     "type": "merchant_revenue",
#     "attributes": {
#       "revenue"  : 532613.9800000001
#     }
#   }
# }
