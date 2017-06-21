class AddItemPicToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :item_pic, :string
  end
end
