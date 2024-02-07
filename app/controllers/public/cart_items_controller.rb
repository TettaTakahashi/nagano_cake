class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
      @cart_item=CartItem.new(cart_item_params)
      @cart_item.save
  end
  
  private
  
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
