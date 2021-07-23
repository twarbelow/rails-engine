require 'rails_helper'

RSpec.describe ' /api/v1/revenue/unshipped?quantity=<number>' do
  it 'returns a default of 10 responses, properly formatted' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant1, status: 'shipped', created_at: 1.days.ago.strftime('%Y-%m-%d'))
    this_one = create(:invoice, merchant: merchant1, status: 'pending', created_at: 3.days.ago.strftime('%Y-%m-%d'))
    invoice4 = create(:invoice, merchant: merchant1, status: 'pending', created_at: 4.days.ago.strftime('%Y-%m-%d'))
    invoice5 = create(:invoice, merchant: merchant2, status: 'shipped', created_at: 5.days.ago.strftime('%Y-%m-%d'))
    invoice6 = create(:invoice, merchant: merchant2, status: 'shipped', created_at: 6.days.ago.strftime('%Y-%m-%d'))
    this_two = create(:invoice, merchant: merchant2, status: 'pending', created_at: 7.days.ago.strftime('%Y-%m-%d'))
    invoice8 = create(:invoice, merchant: merchant2, status: 'pending', created_at: 8.days.ago.strftime('%Y-%m-%d'))
    create(:invoice_item, invoice: invoice1, quantity: 1, unit_price: 2.0)
    create(:invoice_item, invoice: this_one, quantity: 3, unit_price: 4.0) #12
    create(:invoice_item, invoice: this_one, quantity: 11, unit_price: 4.0) #44
    create(:invoice_item, invoice: invoice4, quantity: 46, unit_price: 4.0)
    create(:invoice_item, invoice: invoice5, quantity: 40, unit_price: 11.0)
    create(:invoice_item, invoice: invoice6, quantity: 40, unit_price: 11.0)
    create(:invoice_item, invoice: this_two, quantity: 40, unit_price: 11.0) #440
    create(:invoice_item, invoice: invoice8, quantity: 40, unit_price: 11.0)
    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: this_one, result: 'success')
    create(:transaction, invoice: invoice4, result: 'failed')
    create(:transaction, invoice: invoice5, result: 'success')
    create(:transaction, invoice: invoice6, result: 'success')
    create(:transaction, invoice: this_two, result: 'success')
    create(:transaction, invoice: invoice8, result: 'failed')

    get '/api/v1/revenue/unshipped'

    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: :true)

    expect(reply[:data].count).to eq(10)
    expect(reply[:data][0][:id]).to eq(this_one.id.to_s)
    expect(reply[:data][1][:id]).to eq(this_two.id.to_s)
  end

  # xit 'returns a custom number of responses' do
  #
  #   get '/api/v1/revenue/unshipped?quantity=1'
  #
  #   expect(response.status).to eq(200)
  #
  #   reply = JSON.parse(response.body, symbolize_names: :true)
  # end
  #
  # xit 'returns an error if 0 is passed in query params' do
  #   get '/api/v1/revenue/unshipped?quantity=0'
  #   expect(response.status).to eq(400)
  # end
  #
  # xit 'returns an error if string is passed in query params' do
  #   get '/api/v1/revenue/unshipped?quantity=number'
  #   expect(response.status).to eq(400)
  # end
end
