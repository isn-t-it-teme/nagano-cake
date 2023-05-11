class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    #urlにジャンルidがあるとき
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:id])
    #indexのページの表示
    else
      @items = Item.page(params[:page]).per(8).order(id: "DESC")
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
    @customer = current_customer
  end

  #検索機能アクション
  def search
    @items = Item.search(params[:keyword]).page(params[:id])
    @keyword = params[:keyword]
    @genres = Genre.all
    render "index"
  end
end

