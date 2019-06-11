# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :manufacturer
      t.string :model
      t.integer :price
      t.integer :weight
      t.text :description

      t.timestamps
    end
  end
end
