class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.page(params[:page]).per(10).order(id: "DESC")
    @order_total = 0
  end
  def about
  end
end
