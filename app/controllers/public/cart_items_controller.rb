class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    new_cart_item = CartItem.new(cart_item_params)
    new_cart_item.customer_id = current_customer.id
    new_cart_item.item_id = cart_item_params[:item_id]
    new_cart_item.save
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:count, :item_id)
  end
end
