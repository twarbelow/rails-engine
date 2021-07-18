class Api::V1::ItemsController < ApplicationController
  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.render(item), status: 201
    else
      render status: 422
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
