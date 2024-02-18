class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    
    def show
      @order=Order.find(params[:id])
      @customer=Customer.find(params[:id])
      @order_details=OrderDetail.all
      @shipping_fee=800
      
      any=[]
      @order.order_details.each do |order_detail|
        any << order_detail.item.add_tax_price*order_detail.amount
      end
      @order_details_price=any.sum
    
      @total_price=@shipping_fee+@order_details_price
    end
end