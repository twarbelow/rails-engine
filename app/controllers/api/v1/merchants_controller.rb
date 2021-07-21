class Api::V1::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.render(merchant)
  end

  def find_all
    if valid_params?
      merchants = Merchant.where('name ILIKE ?', "%#{params[:name]}%").order(:name)
      render json: MerchantSerializer.render_all(merchants)
    else
      render status: :bad_request
    end
  end

  private

  def valid_params?
    params[:name] && params[:name].delete(' ').present?
  end
end
