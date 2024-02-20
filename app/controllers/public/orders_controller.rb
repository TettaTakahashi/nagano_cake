class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order=Order.new
    @addresses=current_customer.shipping_addresses.all
  end
  
  def index
    @customer=current_customer
    @orders=@customer.orders
  end
  
  def show
    @order=Order.find(params[:id])
    @shipping_fee=800
    
    any=[]
    @order.order_details.each do |order_detail|
      any << order_detail.item.add_tax_price*order_detail.amount
    end
    @order_details_price=any.sum
    
    @total_price=@shipping_fee+@order_details_price
  end
  
  def check
    @cart_items=CartItem.where(customer_id: current_customer.id)
    @shipping_fee=800
    @selected_payment_method=params[:order][:payment_method]
    
    any=[]
    @cart_items.each do |cart_item|
      any << cart_item.item.price*cart_item.amount
    end
    @cart_items_price=any.sum
    
    @total_price=@shipping_fee+@cart_items_price
    @address_type=params[:order][:address_type]
    case @address_type
    when "customer_address"
      @selected_address=current_customer.postal_code+" "+current_customer.address+" "+current_customer.first_name+current_customer.last_name
    when "shipping_address"
      unless params[:order][:shipping_address_id] == ""
        selected=ShippingAddress.find(params[:order][:shipping_address_id])
        @selected_address=selected.postal_code+" "+selected.address+" "+selected.address_name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address=params[:order][:new_postal_code]+ " "+params[:order][:new_address]+" "+params[:order][:new_address_name]
      else
        render :new
      end
    end
  end
  
  def create
     @order=Order.new
     @order.customer_id=current_customer.id
     @shipping_fee=800
     @order.shipping_fee=@shipping_fee
     @cart_items=CartItem.where(customer_id: current_customer.id)
     any=[]
     @cart_items.each do |cart_item|
       any << cart_item.item.price*cart_item.amount
     end
     @cart_items_price=any.sum
     @order.total_price=@shipping_fee+@cart_items_price
     @order.payment_method=params[:order][:payment_method]
     if @order.payment_method=="credit_card"
       @order.order_status=1
     else
       @order.order_status=0
     end
     
     address_type=params[:order][:address_type]
     case address_type
     when "customer_address"
       @order.postal_code=current_customer.postal_code
       @order.address=current_customer.address
       @order.address_name=current_customer.first_name+current_customer.last_name
     when "shipping_address"
       ShippingAddress.find(params[:order][:shipping_address_id])
       selected=ShippingAddress.find(params[:order][:shipping_address_id])
       @order.postal_code=selected.postal_code
       @order.address=selected.address
       @order.address_name=selected.name
     when "new_address"
       @order.postal_code=params[:order][:new_postal_code]
       @order.address=params[:order][:new_address]
       @order.address_name=params[:order][:new_name]
     end
     
     if @order.save
       if @order.order_status==0
         @cart_items.each do |cart_item|
           OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
         end
       else
         @cart_items.each do |cart_item|
           OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 1)
         end
       end
       @cart_items.destroy_all
       redirect_to orders_completion_path
     else
       render :items
     end
  end
  
  def completion
    
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :address_name, :total_price, :shipping_fee, :payment_method, :order_status)
  end
end
