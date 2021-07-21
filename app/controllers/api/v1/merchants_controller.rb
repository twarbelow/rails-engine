class Api::V1::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.render(merchant)
  end

  def find_all
    merchants = Merchant.where("name ILIKE ?", "%#{params[:name]}%").order(:name)
    render json: MerchantSerializer.render_all(merchants)
  end
end
