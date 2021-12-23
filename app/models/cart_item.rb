class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :count, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 20}

  # 小計を求めるメソッド
  def subtotal_price
    item.with_tax_price * count
  end

    # 合計を求めるメソッド
  def self.calc_total_price(my_cart_items)
    total_price = 0
    my_cart_items.each do |cart_item|
      total_price += cart_item.subtotal_price
    end
    total_price
  end
end
