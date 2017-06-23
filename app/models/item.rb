class Item < ApplicationRecord
  require 'kaminari'
  belongs_to :seller, class_name:"User", foreign_key:"seller_id"
  belongs_to :order, optional:true
  has_one :buyer, class_name:"User", foreign_key:"buyer_id", through: :order
  has_one :review
  belongs_to :category
  mount_uploader :item_pic, ItemPicUploader
  paginates_per 3



  validates :name, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :category, presence: true
  validates :price, :presence => true, :format => { :with => /\A(\$)?(\d+)(\.|,)?\d{0,2}?\z/ }

  def self.conditions
    ["Brand New", "Like New", "Very Good", "Good", "Acceptable"]
  end

  def self.unsold
    Item.where("order_id IS NULL")
  end

  def self.search_unsold(query)
    self.unsold.where("name ILIKE ?", '%' + query + '%')
  end
end
