# frozen_string_literal: true

class AddRelationships < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user, index: true
    add_reference :users, :item, index: true
  end
end
