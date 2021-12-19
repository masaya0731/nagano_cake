class Admin::CustomersController < ApplicationController
  def index
    # kaminariを使用した記述
    @customers = Customer.page(params[:page])
  end

  def show
    # 会員詳細の表示
    @customer = Customer.find(params[:id])
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
    else
      render edit_admin_customer_path
    end
  end

   private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :last_name_kana, :post_code, :address, :email, :tel, :is_deleted)
    end
end