class Public::OrdersController < ApplicationController

  # 注文情報入力画面
  def new
    # 購入情報の入力画面で、宛先や住所などを入力する
    @order = Order.new
    @address = current_customer.address
    @customer = Customer.find(current_customer.id)
    @delivery_addresses = @customer.delivery_addresses.all
  end

  # 注文新規登録&購入を確定します
  def create # Orderに情報を保存
    # ログインユーザーのカートアイテムを全て取り出してcart_itemsに入れる
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      # 取り出したカートアイテムの数繰り返す
      cart_items.each do |cart|
        # order_item にも一緒にデータを保存
        order_detail = OrderDetail.new
        order_detail.count = cart.count
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        # 購入が完了したらカート情報は削除するのでこちらに保存
        # order_detail.count = cart.count
        # カート情報を削除するので item との紐付けが切れる前に保存
        order_detail.price_with_tax = cart.item.price_without_tax
        order_detail.save
      end
      # ユーザーに関連するカートのデータ(購入したデータ)を全て削除(カートを空にする)
      cart_items.destroy_all
      redirect_to public_orders_finish_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  # 注文履歴一覧画面
  def index
    @orders = current_customer.orders
  end

  # 注文履歴詳細画面
  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
    # @order_details = OrderDetail.where(order_id: params[:id])
  end

  # 注文情報確認画面
  def check
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    #address_number と定義した1～3の番号でif文を作成
    if params[:order][:address_number] == "0"
        # 配送先を自分の住所にした場合 = 0
        @order.address = current_customer.address
        @order.post_code = current_customer.post_code
        @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_number] == "1"
        # 配送先に登録した配送先を選んだ場合 = 1
        @delivery_address = DeliveryAddress.find(params[:order][:address_id].to_i)
        @order.post_code = @delivery_address.post_code
        @order.address = @delivery_address.address
        @order.name = @delivery_address.name
    else
        # 配送先を新規登録した場合
        @order.address = params[:order][:address]
        @order.post_code = params[:order][:post_code]
        @order.name = params[:order][:full_name]
        # 新規配送先の中身を保存
        @new_address = DeliveryAddress.new
        @new_address.address = params[:order][:address]
        @new_address.post_code = params[:order][:post_code]
        @new_address.name = params[:order][:full_name]
        @new_address.customer_id = current_customer.id
        @new_address.save
    end
    # 金額を表示
    @cart_item_total_price = 0
  end

  # 注文完了画面
  def finish
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :delivery_cost, :total_payment, :payment_method, :order_status)
  end
end
