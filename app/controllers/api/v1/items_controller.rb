class Api::V1::ItemsController < ApplicationController
  def index
    per_page = params.fetch(:per_page, 20).to_i
    page = params.fetch(:page, 0).to_i
    items = Item.paginated_items(page, per_page)
    render json: ItemSerializer.render_all(items), status: :ok
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

  def find
    if valid_params?
      item = Item.get_by_params(params[:name], params[:min_price], params[:max_price])
      render json: ItemSerializer.render(item), status: :ok if item
      render json: ItemSerializer.render_empty, status: :not_found unless item
    else
      render status: :bad_request
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def valid_params?
    price = (params[:min_price] || params[:max_price]) && !params[:name]
    name = params[:name] && !params[:max_price] && !params[:min_price]
    return valid_price? if price
    return valid_name? if name

    price || name
  end

  def valid_price?
    if params[:min_price]
      return false if params[:min_price].to_i.negative? || params[:min_price].empty?
    end
    if params[:max_price]
      return false if params[:max_price].to_i.negative? || params[:max_price].empty?
    end
    return false if (params[:max_price] && params[:min_price]) && params[:max_price].to_i < params[:min_price].to_i

    true
  end

  def valid_name?
    return false if params[:name] && params[:name].empty?

    true
  end
end
