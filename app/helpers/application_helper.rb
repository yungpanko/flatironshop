module ApplicationHelper
  def cart_total
    session[:cart].map do |item_id|
      Item.find(item_id).price
    end.reduce(:+)
  end

  def display_cart_total
    "Total: $#{cart_total}" if cart_total
  end

end
