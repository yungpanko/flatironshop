class CartController < ApplicationController

  def add_to_cart
    @item = Item.find(params[:id])
    if session[:cart].include?(@item.id)
      flash[:notice] = "This item has already been added to your cart."
      redirect_to item_path(@item)
    else
      session[:cart] << @item.id
      redirect_to cart_path
    end
  end

  def show
    @items = []
    current_cart.each do |item_id|
      @items << Item.find(item_id)
    end
  end

  def remove
    current_cart.delete(params[:id].to_i)
    redirect_to cart_path
  end

end
