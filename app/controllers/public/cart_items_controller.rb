class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @update_cart_item = CartItem.find_by(item_id: @cart_item.item_id)

    if @update_cart_item.present?
      @cart_item.amount += @update_cart_item.amount
      @update_cart_item.destroy
    end

    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      render 'customer/items/show'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: (params[:cart_item][:amount]))
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = "商品を削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_end_user.cart_items
    @cart_items.destroy_all
    flash[:success] = "カート内のすべての商品を削除しました"
    redirect_to cart_items_path
  end
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
