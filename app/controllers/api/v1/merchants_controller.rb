class Api::V1::MerchantsController < ApplicationController
  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = params.fetch(:page, 0).to_i
    merchants = if page.zero?
              Merchant.limit(per_page)
            else
              Merchant.limit(per_page).offset((page - 1) * per_page)
            end
    render json: MerchantSerializer.render_all(merchants), status: :ok
  end
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
