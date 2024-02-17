class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    
    def show
      @order=Order.find(params[:id])
      @customer=Customer.find(params[:id])
      @order_details=OrderDetail.all
    end
end