module ApplicationHelper
  def sort_items(sort_query, current_user_id)
    case sort_query
    when "price_low"
      Item.where(user_id: current_user_id).page(params[:page]).order('price ASC')
    when "price_high"
      Item.where(user_id: current_user_id).page(params[:page]).order('price DESC')
    when "manufacturer_asc"
      Item.where(user_id: current_user_id).page(params[:page]).order('manufacturer ASC')
    when "manufacturer_desc"
      Item.where(user_id: current_user_id).page(params[:page]).order('manufacturer DESC')
    else
      Item.where(user_id: current_user_id).page(params[:page]).order('id DESC')
    end
  end
end
