class Api::V1::ItemsController < ApplicationController
  def show
    Item.find(params[:id])
    render json: ItemSerializer.render(Item.find(params[:id])), status: 200
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.render(item), status: 201
    else
      render status: 400
    end
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
