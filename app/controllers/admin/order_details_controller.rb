class Admin::OrderDetailsController < ApplicationController
  def update
     order_detail = OrderDetail.find(order_detail_params[:id])
      if order_detail.update(order_detail_params)
        redirect_to admin_order_path(order_detail.order_id)
      else
        render admin_order_path
      end
  end

  private
    def order_detail_params
      params.require(:order_detail).permit(:making_status, :id)
    end
end
