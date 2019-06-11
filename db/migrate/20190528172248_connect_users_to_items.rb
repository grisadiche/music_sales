# frozen_string_literal: true

class ConnectUsersToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :user_id
  end
end
