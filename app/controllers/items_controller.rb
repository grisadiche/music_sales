class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_items, only: [:index]

  def new
    @new_item = Item.new
  end

  def create
    @new_item = current_user.items.build(safe_params)
    if @new_item.save
      flash.now[:success] = "You added a #{@new_item.model} for: #{current_user.email}."
      redirect_to @new_item
    else
      flash.now[:error] = "We were unable to add a new item - please try again"
      render "new"

    end
  end

  def show
  end

  def edit
  end

  def update
    if @new_item.update(safe_params)
      flash[:success] = "You updated the #{@new_item.model}"
      redirect_to @new_item
    else
      flash.now[:alert] = "Could not update the item, please try again"
      render "edit"
    end
  end

  def destroy
    deleted_model = @new_item.model
    if @new_item.destroy
      flash.now[:alert] = "You deleted the #{deleted_model}!"
      find_items
      render "items/index"

    else
      flash.now[:error] = "unable to delete item"
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
    if current_user
      @items = Item.where(user: current_user)
    else
      @items = Item.all
    end
  end
end
