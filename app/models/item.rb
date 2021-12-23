class Item < ApplicationRecord
  attachment :image
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :price_without_tax, presence: true

  # 消費税を求めるメソッド
  def with_tax_price
      (price_without_tax * 1.1).floor
  end
end
