class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_items, only: [:index]

  def new
    @new_item = Item.new
  end

  def create
    @new_item = current_user.items.build(safe_params)
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
    @items = Item.where(user: current_user)
  end
end
