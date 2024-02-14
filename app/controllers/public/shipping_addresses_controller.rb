class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
     @addresses=ShippingAddress.all
     @address=ShippingAddress.new
  end
  
  def create
      @address=ShippingAddress.new(address_params)
      @address.customer_id=current_customer.id
      @address.save
      redirect_to shipping_addresses_path
  end
  
  def edit
      @address=ShippingAddress.find(params[:id])
  end
  
  def update
     @address=ShippingAddress.find(params[:id])
     if @address=ShippingAddress.update(address_params)
       redirect_to shipping_addresses_path
     else
       render :edit
     end
  end
  
  def destroy
      @address=ShippingAddress.find(params[:id])
      @address.destroy
      redirect_to shipping_addresses_path
  end
  
  
  private
  
  def address_params
      params.require(:shipping_address).permit(:customer_id, :postal_code, :address, :address_name)
  end
end
