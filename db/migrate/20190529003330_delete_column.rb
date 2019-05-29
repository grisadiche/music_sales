class DeleteColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :item_id
  end
end
