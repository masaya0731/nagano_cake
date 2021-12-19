class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :count, presence: true
  validates :price_with_tax, presence: true

   enum making_status: {cannot_be_started: 0, waiting_for_production: 1, in_production: 2, production_completed: 3}
                     # {制作不可:0、制作待ち:1、製作中:2、制作完了:3}
                     
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
