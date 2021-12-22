class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    # kaminariを使用した記述
    @customers = Customer.page(params[:page])
  end

  def show
    # 会員詳細の表示
    @customer = Customer.find(params[:id])
  end

  def show_orders
    @customer = Customer.find(params[:customer_id])
    @order = Order.find_by(id: @customer.id)
    @orders = @customer.orders.page(params[:page]).reverse_order
  end

  def edit
    # 会員情報編集
    @customer = Customer.find(params[:id])
  end

  def update
    # 会員情報の更新
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      redirect_to admin_customer_path(customer.id)
      flash[:success] = "編集が更新されました！"
    else
      render edit_admin_customer_path
      flash.now[:danger] = "注文ステータス更新失敗しました.."
    end
  end

   private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :email, :tel, :is_deleted)
    end
end