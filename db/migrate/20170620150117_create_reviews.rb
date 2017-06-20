class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.references :item

      t.timestamps
    end
  end
end
