class Api::V1::ItemsController < ApplicationController
  def find
    if valid_params?
      item = if params[:name]
               # class methods for item "get_by_whatever", pass the params in
               Item.where('name ILIKE ? OR description ILIKE ?', "%#{params[:name]}%",
                          "%#{params[:name]}%").order(:name).first
             elsif params[:min_price] && !params[:max_price]
               Item.where('unit_price >= ?', params[:min_price]).order(:name).first
             elsif params[:max_price]
               Item.where('unit_price <= ?', params[:max_price]).order(:name).first
             else
               Item.where(unit_price: params[:min_price]..params[:max_price]).order(:name).first
             end
      render json: ItemSerializer.render(item), status: :ok if item
      render json: ItemSerializer.render_empty, status: :not_found unless item
    else
      render status: :bad_request
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.render(item), status: :ok
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.render(item), status: :created
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    item.save
    render json: ItemSerializer.render(item), status: :ok
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
