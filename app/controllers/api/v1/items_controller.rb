class Api::V1::ItemsController < ApplicationController
  def find
    if valid_params?
      if params[:name]
        # class methods for item "get_by_whatever", pass the params in
        item = Item.where("name ILIKE ? OR description ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%").order(:name).first
      elsif params[:min_price] && !params[:max_price]
        item = Item.where("unit_price >= ?", params[:min_price]).order(:name).first
      elsif params[:max_price]
        item = Item.where("unit_price <= ?", params[:max_price]).order(:name).first
      else
        item = Item.where(unit_price: params[:min_price]..params[:max_price]).order(:name).first
      end
      if item
        render json: ItemSerializer.render(item), status: 200
      else
        render json: ItemSerializer.render_empty, status: 200
      end
    else
      render status: 400
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
    price = (params[:min_price] || params[:max_price]) && !params[:name]
    name = params[:name] && !params[:max_price] && !params[:min_price]
    price || name
  end
end
