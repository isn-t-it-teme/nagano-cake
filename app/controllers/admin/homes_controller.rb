class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    @order_total = 0
  end
  def about
  end
end
