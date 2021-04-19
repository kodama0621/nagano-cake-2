class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    if params[:order_detail][:production_status] = 2
      @order_detail.order.update(order_status: 2)
    end
    if @order.order_details.where(production_status: 3).count == @order.order_details.count
      @order_detail.order.update(order_status: 3)
    end
    flash[:success] = "制作ステータスを更新しました"
    redirect_to admin_order_path(@order_detail.order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
