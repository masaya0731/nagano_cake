class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer = Customer.find_by(id: @order.customer.id)
    @order_details = OrderDetail.where(order_id: @order.id)
  end


  def update
      order = Order.find(params[:id])
      if order.update(order_params)
        redirect_to admin_order_path(order.id)
        flash[:success] = "注文ステータスの更新が成功しました！"
      else
        render admin_order_path
        flash.now[:danger] = "注文ステータス更新失敗しました.."
      end
  end

  private
    def order_params
      params.require(:order).permit(:order_status)
    end
end
