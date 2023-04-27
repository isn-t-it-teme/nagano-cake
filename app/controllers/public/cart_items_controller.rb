class Public::CartItemsController < ApplicationController
  def index
    #current_customerに登録されているカート内商品(アソシエーション)
     @cart_items = current_customer.cart_items
     @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    #追加した商品がカート内に存在するかの判断
    if cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
    #カート内の個数をフォームから送られた個数分追加して保存する
      cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: cart_item_params[:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save
      redirect_to cart_items_path
    #存在しない場合は作成
    else @cart_item.save
      redirect_to cart_items_path
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :quantity)
  end

end

