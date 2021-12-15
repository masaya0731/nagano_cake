class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :delivery_cost, presence: true
  validates :total_payment, presence: true
end
