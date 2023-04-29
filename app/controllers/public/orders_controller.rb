class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @postage = 800
    @total = 0
    @cart_items = current_customer.cart_items

    if params[:order][:select_shipping_address] == "0"
      #登録しているcustomerモデルの住所を取得する
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_shipping_address] == "1"
      #お届け先に登録している住所shipping_addressモデルから取得する
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.postal_code = @shipping_address.postal_code
      @order.address = @shipping_address.address
      @order.name = @shipping_address.last_name + @shippinng_address.first_name

    else params[:order][:select_shipping_address] == "2"
      #新しいお届け先の場合


    end




  end

  def completed
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
