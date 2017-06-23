class ItemsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :item_creator_or_admin, only: [:edit, :update, :destroy]

  def index
    if params[:category_id] && params[:seller_id] && params[:seller_id] != "0"
      @items = Item.unsold.where(:category_id => params[:category_id]).where(:seller_id => params[:seller_id])
    elsif params[:category_id]
      @items = Item.unsold.where(:category_id => params[:category_id])
    elsif params[:seller_id] && params[:seller_id] != "0"
      @items = Item.unsold.where(:seller_id => params[:seller_id])
    else
      @items = Item.unsold
    end
    @items = @items.where.not(id:session[:cart])
    @items = @items.where("name ILIKE ?", '%' + params[:query] + '%') if params[:query]
    @items = @items.page(params[:page])
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

  def item_creator_or_admin
    unless current_user == @item.seller || current_user.try(:admin)
      flash[:danger] = "You do not have permission to perform that action."
      redirect_to root_path
    end
  end
end
