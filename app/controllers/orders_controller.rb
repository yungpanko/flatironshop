class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @orders = current_user.orders
  end

  def show
  end

  def new
    @order = Order.new
    @items = check_buyer_is_seller
  end

  def create
    @order = Order.new(order_params)
    @order.buyer_id = current_user.id
    current_cart.each do |item_id|
      @order.items << Item.find(item_id)
    end
    if @order.items.size < 1
      return flash[:danger] = "Your cart is currently empty."
    end

    if @order.valid?
      @order.save
      session[:cart] = []
      UserMailer.order_email(current_user, @order).deliver_now
      redirect_to order_path(@order)
    else
      flash[:danger] << @order.errors.full_messages.first
      redirect_to cart_path
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
    params.require(:order).permit(:buyer_id, :street_address, :zip_code, :city, :state)
  end

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end
