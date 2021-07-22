require 'rails_helper'

RSpec.describe 'single merchant revenue' do
  it 'gets the total revenue for a single merchant when provided with a valid id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    customer = create(:customer)

    invoice_success1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_success2 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_success3 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "shipped") #fail
    invoice_fail1 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: "failure") #fail

    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_success1.id, quantity: 100, unit_price: 1.0)
    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_success2.id, quantity: 200, unit_price: 1.0)
    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_success3.id, quantity: 350, unit_price: 1.0)
    InvoiceItem.create!(item_id: item.id, invoice_id: invoice_fail1.id, quantity: 400, unit_price: 1.0)

    Transaction.create!(invoice_id: invoice_success1.id, credit_card_number: "13513513", credit_card_expiration_date: "10387", result: "success")
    Transaction.create!(invoice_id: invoice_success2.id, credit_card_number: "13513513", credit_card_expiration_date: "10387", result: "success")
    Transaction.create!(invoice_id: invoice_success3.id, credit_card_number: "13513513", credit_card_expiration_date: "10387", result: "fail")
    Transaction.create!(invoice_id: invoice_fail1.id, credit_card_number: "13513513", credit_card_expiration_date: "10387", result: "success")

    get "/api/v1/merchants/revenue/#{merchant.id}"

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data][:id]).to eq(merchant.id.to_s)
    expect(reply[:data][:type]).to eq("merchant_revenue")
    expect(reply[:data][:attributes][:revenue]).to eq(300)
  end

  it 'returns 404 when merchant id does not exist' do
    get "/api/v1/merchants/revenue/123234345"

    expect(response.status).to eq(404)
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
