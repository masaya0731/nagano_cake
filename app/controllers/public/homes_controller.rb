class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    # 商品の新規登録を新しい順に最大４件取得
    @items = Item.all.order(created_at: :desc).limit(4)
  end

  def about
  end

end
