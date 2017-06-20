class ItemsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if current_user == nil
      @items = Item.all
    else
      @items = Item.where.not("seller_id = ?", current_user.id)
    end

  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.seller_id = current_user.id
    if @item.valid?
      @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :condition, :category_id, :seller_id, :order_id)
  end

  def set_item
    @item = Item.find_by(id: params[:id])
  end
end
