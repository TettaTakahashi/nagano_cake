class Admin::HomesController < ApplicationController
     before_action :authenticate_admin!
     
     def top
         @orders=Order.all
         @order_details=OrderDetail.all
         
     end
end
