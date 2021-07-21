class Api::V1::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.render(merchant)
  end

  def find_all
    if params[:name] && !params[:name].empty?
      merchants = Merchant.where("name ILIKE ?", "%#{params[:name]}%").order(:name)
      render json: MerchantSerializer.render_all(merchants)
    else
      render status: 400
    end
  end
end
