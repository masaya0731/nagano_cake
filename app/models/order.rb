class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :delivery_cost, presence: true
  validates :total_payment, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
                     # {クレジットカード:0、銀行振込:1}
  enum order_status: {"入金待ち":0,"入金確認":1, "製作中":2, "発送準備中":3, "発送済み":4}
end
