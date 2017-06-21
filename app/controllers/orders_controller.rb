class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @items = []
    current_cart.each do |item_id|
      @items << Item.find(item_id)
    end
  end

  def create
    @order = Order.new()
    @order.buyer_id = current_user.id
    current_cart.each do |item_id|
      @order.items << Item.find(item_id)
    end
    if @order.valid?
      @order.save
      session[:cart] = []
      redirect_to order_path(@order)
    else
      flash[:danger] = @order.errors.full_messages.first
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:buyer_id)
  end

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end
