class CartController < ApplicationController

  def add_to_cart
    @item = Item.find(params[:id])
    if session[:cart].include?(@item.id)
      flash[:info] = "This item has already been added to your cart."
      redirect_to item_path(@item)
    else
      session[:cart] << @item.id
      flash[:success] = "#{@item.name} added to cart. #{cart_btn}"
      redirect_to items_path
    end
  end

  def show
    @items = []
    current_cart.each do |item_id|
      @items << Item.find(item_id)
    end
    if @items.empty?
      flash[:info] = "Your cart is currently empty!"
      redirect_to root_path
    end
  end

  def remove
    current_cart.delete(params[:id].to_i)
    redirect_to cart_path
  end

  def cart_btn
    view_context.link_to "View Cart", cart_path, class:'btn btn-default'
  end

end
