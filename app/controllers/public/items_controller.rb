class Public::ItemsController < ApplicationController
  def index
    @all_items = Item.all
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8).reverse_order
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @tax_rate = 1.1
    @new_cart_item = CartItem.new
  end




  private
  def item_params
    params.require(:item).permit(:image)
  end
end
