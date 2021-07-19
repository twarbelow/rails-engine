class Api::V1::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render MerchantSerializer.render(merchant)
  end
end
