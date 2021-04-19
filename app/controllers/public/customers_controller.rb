class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_vaild: true)
    reset_session
    redirect_to root_path
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    flash[:success] = "会員情報を更新しました"
    redirect_to customer_path(current_customer)
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :postal_code, :addrees, :phone_number)
  end
end
