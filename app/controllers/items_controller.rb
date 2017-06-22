class ItemsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category_id]
      # @items = current_user.nil? ? Item.unsold.where(:category_id => params[:category_id]) : Item.unsold.where(:category_id => params[:category_id]).where.not("seller_id = ?", current_user.id)
      @items = Item.unsold.where(:category_id => params[:category_id])
    elsif params[:seller_id]
      @items = Item.unsold.where(:seller_id => params[:seller_id])
    else
      # @items = current_user.nil? ? Item.unsold : Item.unsold.where.not("seller_id = ?", current_user.id)
      @items = []
      Item.unsold.each do |item|
        @items << item unless current_cart.include?(item.id)
      end

      # @items = Item.unsold
    end
    if @items.class == Array
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(3)
    else
      @items = @items.page(params[:page])
    end
  end

  # def index
  #   if current_user == nil
  #     @items = Item.unsold
  #   else
  #     @items = Item.unsold.where.not("seller_id = ?", current_user.id)
  #   end
  #
  # end

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
      flash.now[:danger] = []
      @item.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
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
    params.require(:item).permit(:name, :description, :price, :condition, :category_id, :seller_id, :order_id, :item_pic)
  end

  def set_item
    @item = Item.find_by(id: params[:id])
  end
end
