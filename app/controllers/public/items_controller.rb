class Public::ItemsController < ApplicationController
  def index
    @all_items = Item.all
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8).reverse_order
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @new_cart_item = CartItem.new
  end

  def genre_search
    # ジャンル検索欄表示用にジャンルを全て取得
    @genres = Genre.all
    # 受け取ったジャンルIDと同じジャンルをリストから探し取得
    @genre_searched = Genre.find(params[:id])
    # ジャンルが上のgenre_searchと一致する商品のみを（全て）取得
    @all_items_searched = Item.where(genre_id: @genre_searched.id)
    # 直前で受け取った商品の中から、ページネーションのために、８個まで取得
    @items = @all_items_searched.page(params[:page]).per(8).reverse_order
  end

  private
  def item_params
    params.require(:item).permit(:image)
  end
end
