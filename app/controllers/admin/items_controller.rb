class Admin::ItemsController < ApplicationController



  private
  def item_params
    params.require(:item).permit(:image)
  end
end
