class User < ApplicationRecord
  has_secure_password
  has_many :orders, foreign_key: "buyer_id"
  has_many :items_bought, class_name:"Item", through: :orders, source: :items
  has_many :items_sold, class_name:"Item", foreign_key: "seller_id"
end
