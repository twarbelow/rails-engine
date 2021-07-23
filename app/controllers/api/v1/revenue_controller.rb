class Api::V1::RevenueController < ApplicationController
  def total_for_merchant
    merchant = Merchant.find(params[:id])
    revenue = Merchant.revenue_total(merchant)
    render json: RevenueSerializer.merchant_total(merchant.id, revenue)
  end
end
