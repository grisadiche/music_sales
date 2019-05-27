class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_items, only: [:index]

  def new
    @new_item = Item.new
  end

  def create
    @new_item = Item.new(safe_params)
    if @new_item.save
      redirect_to @new_item
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @new_item.update(safe_params)
      redirect_to @new_item
    else
      render "edit"
    end
  end

  def destroy
    if @new_item.destroy
      find_items
      render action: "index"
    else
      render "show"
    end
  end

  def sort
    @sort_option = "price_high"
  end

  def index
  end

  private

  def find_item
    @new_item = Item.find(params[:id])
  end

  def safe_params
    params.require(:item).permit(:manufacturer, :model, :weight, :price, :description, :serial_number, :color, :photo_link)
  end

  def find_items
    case @sort_option
    when "price_high"
      @items = Item.all.sort_by(&:price).reverse
    when "price_low"
      @items = Item.all.sort_by(&:price)
    when "alpha_reverse"
      @items = Item.all.sort_by(&:manufacturer).reverse
    when "alpha_default"
      @items = Item.all.sort_by(&:manufacturer)
    else
      @items = Item.all.sort_by(&:id).reverse
    end
  end
end
