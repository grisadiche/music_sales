class WelcomeController < ApplicationController
  def welcome
    @items = Item.all
    flash[:notice] = "flash noticed"
    render "items/index"
  end
end
