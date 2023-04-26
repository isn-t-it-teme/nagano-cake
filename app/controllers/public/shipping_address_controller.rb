class Public::ShippingAddressController < ApplicationController
  def index
    @address = Adress.new
  end

  def edit
  end
end
