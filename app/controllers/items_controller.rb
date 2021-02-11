class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_items, only: [:index]

  def new
    @new_item = Item.new
  end

  def create
    @new_item = current_user.items.build(safe_params)
    if save_item_to_database
      flash[:success] = "You added a #{@new_item.model} for: #{current_user.email}."
      redirect_to @new_item
    else
      byebug
      flash.now[:error] = "We were unable to add a new item - please try again. Errors: #{@new_item.errors}" #check api controllers for reference
      render "new"
    end
  end

  def show; end

  def edit; end

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
      render "users/profile"

    else
      flash.now[:error] = "unable to delete item"
      render "show"
    end
  end

  def index; end

  private

  def save_item_to_database
    ActiveRecord::Base.transaction do
      @new_item.save!
      pay_with_stripe!
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  rescue => e
    @new_item.errors.add(:base, e.message)
    false
  end

  def pay_with_stripe!
    byebug
    charge = Stripe::Charge.create({
      amount: 999,
      currency: 'usd',
      description: 'Example charge',
      source: safe_params[:stripe_token],
    })
  end

  def find_item
    @new_item = Item.find(params[:id])
  end

  def safe_params
    params.require(:item).permit(:manufacturer, :model, :weight, :price, :description, :serial_number, :color, :image, :stripe_token)
  end

  def find_items
    items = if current_user
              Item.where.not(user_id: current_user.id)
            else
              Item.all
            end

    sort = params[:sort]

    case sort
    when "price_low"
      @items = items.page(params[:page]).order('price ASC')
    when "price_high"
      @items = items.page(params[:page]).order('price DESC')
    when "manufacturer_asc"
      @items = items.page(params[:page]).order('manufacturer ASC')
    when "manufacturer_desc"
      @items = items.page(params[:page]).order('manufacturer DESC')
    else
      @items = items.page(params[:page]).order('id DESC')
    end
  end
end
