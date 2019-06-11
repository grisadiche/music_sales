# frozen_string_literal: true

class WelcomeController < ApplicationController
  def welcome
    @items = Item.all
    flash[:success] = "You are logged in as #{current_user.email}" if current_user
  end
end
