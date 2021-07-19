class Api::V1::ItemsController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.render(item), status: 200
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
    begin
      # return render status: 400 unless item_params.keys.all? { |k| Item.column_names.include?(k) }
      item = Item.find(params[:id])
      item.update_attributes!(item_params)
      item.save
      render json: ItemSerializer.render(item), status: 200
    rescue ActiveRecord::RecordNotFound
      render status: 404
    rescue ActiveRecord::RecordInvalid
      render status: 400
    end
  end

  def destroy
    begin
      Item.destroy(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
