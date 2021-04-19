class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    flash[:success] = "会員情報を更新しました"
    redirect_to admin_customer_path(@customer)
  end

  def customer_orders
    @customer = Customer.find(params[:id])
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, :addrees, :email, :is_vaild)
  end

end
