module ApplicationHelper
  def cart_total
    session[:cart].map do |item_id|
      Item.find(item_id).price
    end.reduce(:+)
  end

  def display_cart_total
    "Total: $#{cart_total}" if cart_total
  end

  def category_link(category)
    link_to category.name.capitalize, items_path(category_id: category.id), class:"list-group-item #{params[:category_id].to_i == category.id ? 'active' : ''}"
  end
end
