class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
      @item=Item.new
  end
  
  def create
      @item=Item.new(item_params)
      @item.save
      redirect_to admin_item_path(@item)
  end
  
  def index
    @items=Item.all
  end
  
  def show
      @item=Item.find(params[:id])
  end
  
  def edit
    @item=Item.find(params[:id])
  end
  
  def update
    @item=Item.find(params[:id])
    if @item=Item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end
  
  private
  
  def item_params
      params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
  end
end
