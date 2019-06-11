# frozen_string_literal: true

class AddMoreColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :photo_link, :string
    add_column :items, :color, :string
  end
end
