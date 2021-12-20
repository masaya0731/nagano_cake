class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).reverse_order
    @customers = Customer.all
  end
end
