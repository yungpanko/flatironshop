module ApplicationHelper
  def cart_total
    session[:cart].map do |item_id|
      Item.find(item_id).price
    end.reduce(:+)
  end

  def display_cart_total
    "#{number_to_currency(cart_total, :precision => 2)}" if cart_total

  end

  def category_link(category, params)
    if params[:query]
      items = Item.unsold.where("name ILIKE ?", '%' + params[:query] + '%')
    else
      items = Item.unsold
    end

    if !params[:seller_id].nil? && params[:seller_id] != "0"
      link_to items_path(category_id: category.id, seller_id: params[:seller_id], query: params[:query]), class:"list-group-item #{params[:category_id].to_i == category.id ? 'active' : ''}" do
        "#{category.name.capitalize} #{content_tag :span, items.where(category_id: category, seller_id:params[:seller_id]).count, class:'badge'}".html_safe
      end
    else
      link_to items_path(category_id: category.id, seller_id: params[:seller_id], query: params[:query]), class:"list-group-item #{params[:category_id].to_i == category.id ? 'active' : ''}" do
        "#{category.name.capitalize} #{content_tag :span, items.where(category_id: category).count, class:'badge'}".html_safe
      end
    end
  end

end
