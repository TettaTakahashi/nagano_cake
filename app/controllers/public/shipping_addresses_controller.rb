class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
     @addresses=ShippingAddress.all
     @address=ShippingAddress.new
  end
  
  def create
      @address=ShippingAddress.new(address_params)
      @address.save
      redirect_to shipping_addresses_path
  end
  
  
  private
  
  def address_params
      params.require(:shipping_address).permit(:customer_id, :postal_code, :address, :address_name)
  end
end
