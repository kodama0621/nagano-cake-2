class Public::AddressesController < ApplicationController
    def index
        @address = Address.new
        @addresses = Address.all
    end

    def create
        @address = Address.new(address_params)
        @address.end_user_id = current_end_user.id
        @address.save
        flash[:success] = "配送先を登録しました"
        redirect_to addresses_path
    end

    def edit
        @address = Address.find(params[:id])
    end

    def update
        @address = Address.find(params[:id])
        @address.update(address_params)
        flash[:success] = "配送先を更新しました"
        redirect_to addresses_path
    end

    def destroy
        @address = Address.find(params[:id])
        @address.destroy
        flash[:success] = "配送先を削除しました"
        redirect_to addresses_path
    end

    private
    def address_params
        params.require(:address).permit(:name, :address, :postal_code)
    end
end
