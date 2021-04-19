class Public::OrdersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :check_cart_item, except: :complete

  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(
    customer: current_customer,
    payment_method: params[:order][:payment_method]
    )

    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      if params[:point] == "true"
        @order.total_price = total_price(@cart_items) - @order.customer.point
      elsif
        @order.total_price = total_price(@cart_items)
      end
    elsif params[:order][:address_option] == "1"
      @ship = Address.find(params[:order][:address_id])
      @order.postal_code = @ship.postal_code
      @order.address = @ship.address
      @order.name = @ship.name
      @order.total_price = total_price(@cart_items)
    elsif params[:order][:address_option] = "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @order.total_price = total_price(@cart_items)
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items
    if @order.total_price != total_price(@cart_items)
      current_customer.update(point: 0)
    end

    @cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

  def check_cart_item
   unless current_customer.cart_items.present?
     redirect_to cart_items_path
   end
  end
end
