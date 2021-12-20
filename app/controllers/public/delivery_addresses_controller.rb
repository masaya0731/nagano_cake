class Public::DeliveryAddressesController < ApplicationController

  # 配送先一覧画面
  def index
    @delivery_address = DeliveryAddress.new
    @delivery_addresses = current_customer.delivery_addresses.all
  end

  # 配送先情報編集画面
  def edit
    @delivery_address = DeliveryAddress.find(params[:id])
  end

  # 配送先新規登録
  def create
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    @delivery_address.customer_id = current_customer.id
    if @delivery_address.save
      flash[:notice] = "新規配送先を登録しました。"
      redirect_to public_delivery_addresses_path
    else
      @delivery_addresses = current_customer.delivery_addresses
      render :index
    end
  end

  # 配送先情報更新
  def update
    @delivery_address = DeliveryAddress.find(params[:id])
    if @delivery_address.update(delivery_address_params)
      flash[:notice] = "配送先情報を更新しました。"
      redirect_to public_delivery_addresses_path
    else
      render :edit
    end
  end

  # 配送先削除
  def destroy
    @delivery_address = DeliveryAddress.find(params[:id])
    @delivery_address.destroy
    flash[:notice] = "選択した配送先の消去が完了しました。"
    redirect_to public_delivery_addresses_path
  end


  private
  def delivery_address_params
    params.require(:delivery_address).permit(:name, :address, :post_code)
  end
end
