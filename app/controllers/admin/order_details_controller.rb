class Admin::OrderDetailsController < ApplicationController
   before_action :authenticate_admin!

def update
    @order_detail = OrderDetail.find(order_detail_params[:id])
    @order = Order.find(@order_detail.order_id)
    @order_details = @order.order_details

    if @order_detail.update(making_status: order_detail_params[:making_status])
        if @order_detail.making_status == "製作中"# 紐づく商品のmaking_statusがひとつでも「製作中」になったら
             @order.update(order_status: "製作中")# 注文ステータスを「製作中」に"自動更新"
        elsif @order_details.pluck(:making_status).all?{ |status| status == "製作完了" }#紐づく商品のmaking_statusが全て「製作完了」になったら
             @order.update(order_status: "発送準備中") #注文ステータスを「発送準備中」に"自動更新"
        end
        redirect_to admin_order_path(@order_detail.order_id)
         flash[:success] = "製作ステータスの更新が成功しました！"
    else
         render admin_order_path
        flash.now[:danger] = "製作ステータス更新失敗しました.."
    end
end

  private
    def order_detail_params
        params.require(:order_detail).permit(:making_status, :id)
    end
end
