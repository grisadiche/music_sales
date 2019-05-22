class AddSerialNumberToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :serial_number, :string
  end
end
