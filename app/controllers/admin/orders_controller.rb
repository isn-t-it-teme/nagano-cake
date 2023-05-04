class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @total = 0
    @customer = @order.customer
  end

  #注文ステータスの更新
  def update
    #注文詳細データの取得
    @order = Order.find(params[:id])
    @order_product = @order.order_products
    #注文ステータスの更新
    @order.update!(order_params)
    #注文商品の注文ステータスが「入金確認」だったら
    if params[:order][:status] == 'confirmation'
    #注文商品の制作ステータスを「制作待ち」に更新
      @order_product.update(production_status: "waiting_for_production")
    end
    redirect_to admin_order_path
  end


  private

  def order_params
    params.require(:order).permit(:payment, :postal_code, :address, :name, :customer_id, :total_price, :postage, :status)
  end
end
