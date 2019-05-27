class WelcomeController < ApplicationController
  def welcome
    @items = Item.all
    if current_user&.id
      flash[:success] = "You are logged in as #{current_user.email}"
    end
  end
end
