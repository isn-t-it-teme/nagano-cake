class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:id])
  end

  def show
  end
end
