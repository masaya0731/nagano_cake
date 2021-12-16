class Public::CustomersController < ApplicationController

  #会員マイページ画面を表示
  def show
    @customer = current_customer
  end

  #会員情報編集
  def edit
    @customer = current_customer
  end

  #会員情報更新
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customer_path
  end

  #会員退会画面を表示
  def unsubscribe
    # @customer = Customer.find_by(name: params[:name])
  end

  #会員退会作業
  def withdraw
    @customer = current_customer
    ## is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました" ## 該当viewファイルへ<%= notice %>を
    redirect_to root_path

  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :tel, :password, :email, :is_deleted)
  end
end
