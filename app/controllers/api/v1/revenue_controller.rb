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
