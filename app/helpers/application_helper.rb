module ApplicationHelper

  def sort_items(sort_query, current_user_id)
    case sort_query
    when "price_low"
      items = Item.where(user_id: current_user_id).page(params[:page]).order('price ASC')
    when "price_high"
      items = Item.where(user_id: current_user_id).page(params[:page]).order('price DESC')
    when "manufacturer_asc"
      items = Item.where(user_id: current_user_id).page(params[:page]).order('manufacturer ASC')
    when "manufacturer_desc"
      items = Item.where(user_id: current_user_id).page(params[:page]).order('manufacturer DESC')
    else
      items = Item.where(user_id: current_user_id).page(params[:page]).order('id DESC')
    end
  end
end
