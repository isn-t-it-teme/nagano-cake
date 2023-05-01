class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = Order.new(order_params)
    @postage = 800
    @total = 0
    @cart_items = current_customer.cart_items

    if params[:order][:select_shipping_address] == "0"
      #登録しているcustomerモデルの住所を取得する
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_shipping_address] == "1"
      #お届け先に登録している住所shipping_addressモデルから取得する
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.postal_code = @shipping_address.postal_code
      @order.address = @shipping_address.address
      @order.name = @shipping_address.last_name + @shippinng_address.first_name

    else params[:order][:select_shipping_address] == "2"
      #新しいお届け先の場合


    end
  end

  def create
    #確認画面から送られてきた、配送先、支払方法を取得
    @order = Order.new(order_params)
    #orderモデルに注文を保存
    @order.save
    @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        #OrderProductモデルを作成
        @order_product = OrderProduct.new
        #ordeir.idを取得
        @order_product.order_id = @order.id
        #item.idを取得
        @order_product.item_id = cart_item.item.id
        #数量を取得
        @order_product.product_quantity = cart_item.quantity
        #税抜価格を取得
        @order_product.tax_price = cart_item.item.with_tax_price
        #制作ステータスを取得
        @order_product.production_status = 0
        #order_productモデルに保存
        @order_product.save
      end
    #cart_item内の商品すべてを削除
    @cart_items.destroy_all
    redirect_to orders_completed_path
  end

  def completed
  end

  def index

  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :customer_id, :total_price, :postage, :status)
  end
end
