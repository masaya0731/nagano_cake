class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @tax_rate = 1.1
    @new_cart_item = CartItem.new
  end




  private
  def item_params
    params.require(:item).permit(:image)
  end
end
