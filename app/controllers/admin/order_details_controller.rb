class Admin::OrderDetailsController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @order = Order.find_by(id: @customer.id)
    @orders = @customer.orders.page(params[:page]).reverse_order
  end

  def update
     order_detail = OrderDetail.find(order_detail_params[:id])
      if order_detail.update(order_detail_params)
        redirect_to admin_order_path(order_detail.order_id)
        flash[:success] = "製作ステータスの更新が成功しました！"
      else
        render admin_order_path
        flash.now[:danger] = "注文ステータス更新失敗しました.."
      end
  end

  private
    def order_detail_params
      params.require(:order_detail).permit(:making_status, :id)
    end
end
