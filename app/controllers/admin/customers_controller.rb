class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!
    
    def index
        @customers=Customer.all
        @customers=Kaminari.paginate_array(@customers).page(params[:page])
    end
    
    def show
        
    end
    
    def edit
        
    end
    
    def update
        
    end
end
