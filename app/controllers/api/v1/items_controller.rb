class Api::V1::ItemsController < ApplicationController
  def show
    item_id = params[:id]
    render json: ItemSerializer.render(Item.find(item_id)), status: 200
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.render(item), status: 201
  end

  def update
    item = Item.find(params[:id])
    item.update_attributes!(item_params)
    item.save
    render json: ItemSerializer.render(item), status: 200
  end

  def destroy
    Item.destroy(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
