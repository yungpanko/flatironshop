class Order < ApplicationRecord
  has_many :items
  has_many :sellers, class_name:"User", through: :items, foreign_key:"seller_id"
  belongs_to :buyer, class_name:"User", foreign_key:"buyer_id"
end
