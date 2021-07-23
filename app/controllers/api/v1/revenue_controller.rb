class Api::V1::RevenueController < ApplicationController
  def total_for_merchant
    merchant = Merchant.find(params[:id])
    revenue = merchant.invoices.joins(:transactions, :invoice_items).where(
      'transactions.result = ? AND invoices.status = ?', 'success', 'shipped'
    ).sum('invoice_items.unit_price * invoice_items.quantity')
    render json: RevenueSerializer.merchant_total(merchant.id, revenue)
  end

  def unshipped
    require 'pry'; binding.pry
    unshipped = Invoice.joins(:transactions).where('transactions.result = ?', 'success').where.not( 'invoices.status = ?', 'shipped')
    unshipped_invoice_items = unshipped.map do |invoice|
                                invoice.invoice_items
                              end

    # we want the invoice id, and the total revenue from that unshipped invoice (all invoice_items attached to it and summed)
  end
end
Invoice.joins(:transactions, :invoice_items).where('transactions.result = ?', 'success').where.not( 'invoices.status = ?', 'shipped').distinct
# merchant.invoices.joins(:transactions).where( result: 'success', status: 'shipped')
#
# find invoices where
# (result: success) from transactions table && (status: shipped) from invoices table
# get the invoiceitems from the resulting invoices
# sum the unit_price times the quantity on all relevant invoiceitems
