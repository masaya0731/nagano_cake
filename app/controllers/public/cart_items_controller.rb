class Public::CartItemsController < ApplicationController
  # 顧客としてログインしていないと、自動的にログイン画面に遷移
  before_action :authenticate_customer!

  def index
    @my_cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    my_cart_items = CartItem.where(customer_id: current_customer.id)
    # my_cart_itemsの中に、追加しようとしている商品と同じ物を取得
    same_cart_item = my_cart_items.find_by( item_id: cart_item_params[:item_id])
     # my_cart_itemsの中に、追加しようとしている商品と同じ物は存在しているかでcreateの仕方を変える
    if same_cart_item.blank?
      # 同じ商品がなければ、新たに商品を追加
      new_cart_item = CartItem.new(cart_item_params)
      new_cart_item.customer_id = current_customer.id
      new_cart_item.save
      flash[:success] = "新たに#{new_cart_item.item.name}をカートに入れました"
    else
      # 同じ商品があれば、その商品の個数に数を加算する
      total_count = same_cart_item.count + cart_item_params[:count].to_i
      if total_count <= 20
        # 結果個数が20個以下なら普通に加算する
        same_cart_item.update(count: total_count)
        flash[:success] = "#{same_cart_item.item.name}の数を#{cart_item_params[:count]}個増やしました"
      else
        # 結果個数が20個を超えるなら、個数を20個にした上でフラッシュメッセージ
        same_cart_item.update(count: 20)
        flash[:danger] = "同じ商品は20個まで入れられます。#{same_cart_item.item.name}の数を20個にしました"
      end
    end
    redirect_to public_cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:success] = "#{cart_item.item.name}をカートから削除しました"
    redirect_to public_cart_items_path
  end

  def destroy_all
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.destroy_all
    flash[:success] = "カートを空にしました"
    redirect_to public_cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(count: cart_item_params[:count])
    flash[:success] = "#{cart_item.item.name}の数を#{cart_item_params[:count]}個に変更しました"
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:count, :item_id)
  end
end
