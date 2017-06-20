class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :seller_id, foreign_key:true
      t.integer :order_id, foreign_key:true

      t.timestamps
    end
  end
end
