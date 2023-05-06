class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
     #urlにジャンルidがあるとき
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:id])
    #indexのページの表示
    else
      @items = Item.page(params[:id])
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  #検索機能アクション
  def search
    @items = Item.search(params[:keyword]).page(params[:id])
    @keyword = params[:keyword]
    @genres = Genre.all
    render "index"
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :sale_status)
  end
end
