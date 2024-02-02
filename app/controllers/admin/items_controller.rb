class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
      @item=Item.new
  end
  
  def create
      @item=Item.new(item_params)
      @item.save
      redirect_to admin_item_path
  end
  
  def show
      
  end
  
  private
  
  def item_params
      params.require(:item).permit(:image, :name, :introduction)
  end
end
