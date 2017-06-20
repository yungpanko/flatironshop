class Item < ApplicationRecord
  belongs_to :seller, class_name:"User", foreign_key:"seller_id"
  belongs_to :order, optional:true
  has_one :buyer, class_name:"User", foreign_key:"buyer_id", through: :order
end
