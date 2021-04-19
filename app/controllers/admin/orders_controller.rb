class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def updatepara
    @order = Order.find(params[:id])
    @order.update(order_params)
    if params[:order][:order_status] = "1"
      @order.order_details.each do |order_detail|
        order_detail.update(production_status: 1)
      end
    end
    flash[:success] = "注文ステータスを更新しました"
    redirect_to admin_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end
end
