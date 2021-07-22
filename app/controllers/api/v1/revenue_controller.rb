class Api::V1::RevenueController < ApplicationController
  def total_for_merchant
    merchant = Merchant.find(params[:id])
    shipped_invoices = merchant.invoices.joins(:transactions).where( 'transactions.result = ? AND invoices.status = ?', 'success',  'shipped')
    invoice_items = shipped_invoices.map do |item|
      item.invoice_items
    end
    revenue = 0
    invoice_items.each do |invoiceitem|
      revenue += invoiceitem.sum( 'unit_price * quantity' )
    end
    render json: RevenueSerializer.merchant_total(merchant.id, revenue)
  end
end

# merchant.invoices.joins(:transactions).where( result: 'success', status: 'shipped')
#
# find invoices where
# (result: success) from transactions table && (status: shipped) from invoices table
# get the invoiceitems from the resulting invoices
# sum the unit_price times the quantity on all relevant invoiceitems
