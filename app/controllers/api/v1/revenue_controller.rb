class Api::V1::RevenueController < ApplicationController
  def total_for_merchant
    merchant = Merchant.find(params[:id])
    revenue = merchant.invoices
                      .joins(:transactions, :invoice_items)
                      .where('transactions.result = ? AND invoices.status = ?', 'success', 'shipped')
                      .sum('invoice_items.unit_price * invoice_items.quantity')
    render json: RevenueSerializer.merchant_total(merchant.id, revenue)
  end
end

# merchant.invoices.joins(:transactions).where( result: 'success', status: 'shipped')
#
# find invoices where
# (result: success) from transactions table && (status: shipped) from invoices table
# get the invoiceitems from the resulting invoices
# sum the unit_price times the quantity on all relevant invoiceitems
