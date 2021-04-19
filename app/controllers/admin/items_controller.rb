class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def index
    @items = Item.search(params[:search])
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash[:success] = "商品情報を変更しました"
    redirect_to admin_item_path(@item)
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :explanation, :image, :price, :is_active)
  end

end
