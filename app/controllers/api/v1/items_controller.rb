class Api::V1::ItemsController < ApplicationController
  def create
    if item_params.keys.count == 4
      item = Item.create(item_params)
      render json: ItemSerializer.render(item), status: 201
    else
      render status: 400
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
