class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:id])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
end
