class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order=Order.new
  end
  
  def create
    @order=Order.new(order_params)
    @order.customer_id=current_customer.id
    @order.save
    redirect_to orders_check_path
  end
  
  def check
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :address_name, :total_price, :postage, :payment_method, :order_status)
  end
end
