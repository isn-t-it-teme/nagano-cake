class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
  end

  def completed
  end

  def index
  end

  def show
  end
end
