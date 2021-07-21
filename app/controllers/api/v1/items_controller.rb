class Api::V1::ItemsController < ApplicationController
  def find
    if valid_params?
      item = Item.where("name ILIKE ? OR description ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%").order(:name).first
      render json: ItemSerializer.render(item), status: 200
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.render(item), status: 200
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

  def valid_params?
    (params[:min_price] || params[:max_price] && !params[:name]) || (params[:name] && !params[:max_price] && !params[:min_price])
  end
end
