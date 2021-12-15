class Item < ApplicationRecord
  attachment :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image_id, presence: true
  validates :price_without_tax, presence: true
end
