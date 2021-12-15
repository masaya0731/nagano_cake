class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :count, presence: true
  validates :price_with_tax, presence: true
end
