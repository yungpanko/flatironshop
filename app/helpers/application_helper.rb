module ApplicationHelper
  def cart_total
    session[:cart].map do |item_id|
      Item.find(item_id).price
    end.reduce(:+)
  end

  def display_cart_total
    "#{number_to_currency(cart_total, :precision => 2)}" if cart_total

  end

  def category_link(category, *seller_id)
    link_to category.name.capitalize, items_path(category_id: category.id, seller_id: seller_id.first.to_i, query: params[:query]), class:"list-group-item #{params[:category_id].to_i == category.id ? 'active' : ''}"
  end

end
