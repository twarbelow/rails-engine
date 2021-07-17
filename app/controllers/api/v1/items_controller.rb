class Api::V1::ItemsController < ApplicationController
  def create
    item = Item.create(item_params)
    render json: ItemSerializer.render(item), status: 201
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
