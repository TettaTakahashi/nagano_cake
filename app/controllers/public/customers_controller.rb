class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer=Customer.find(current_customer.id)
    
  end
  
  def edit
    @customer=Customer.find(current_customer.id)
  end
  
  def update
    customer=Customer.find(current_customer.id)
    customer.update(customer_params)
    redirect_to public_customer_path(current_customer.id)
  end
  
  def confirm_withdraw
    
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email)
  end
  
end
