class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @total = 0
    @customer = @order.customer
  end

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :customer_id, :total_price, :postage, :status)
  end
end
