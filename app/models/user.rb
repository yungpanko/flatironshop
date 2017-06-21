class User < ApplicationRecord
  has_secure_password
  has_many :orders, foreign_key: "buyer_id"
  has_many :items_bought, class_name:"Item", through: :orders, source: :items
  has_many :items_sold, class_name:"Item", foreign_key: "seller_id"
  has_many :reviews, through: :items_sold

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def average_rating
    reviews.average(:rating).to_f
  end

  def listed_items
    self.items_sold.where("order_id IS NULL")
  end

end
