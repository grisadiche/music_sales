class RemovePhotoLinkColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :photo_link
  end
end
