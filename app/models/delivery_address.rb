class DeliveryAddress < ApplicationRecord
  belongs_to :customer

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  # Addressモデル
  def full_address
    '〒' + post_code + ' ' + address + ' ' + name
  end
end
