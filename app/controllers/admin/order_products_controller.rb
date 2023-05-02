class Admin::OrderProductsController < ApplicationController
  #制作ステータスの更新
  def update
    #注文詳細データを取得
    @order_product = OrderProduct.find(params[:id])
    #注文詳細に紐づく注文データを取得
    @order = @order_product.order
    #制作ステータスを更新
    @order_product.update(order_product_params)
    #注文に紐づく注文詳細の制作ステータスが一つでも「制作中」だったら
    if params[:order_product][:production_status] == 'in_production'
    #注文の注文ステータスを「制作中」に更新
      @order.update(status: "production")
    end
    #注文に紐づく注文詳細の制作ステータスが全部「制作完了」だったら
    if @order.order_products.count == @order.order_products.where(production_status: "completion_of_production").count
    #注文の注文ステータスを「発送準備中」に更新
      @order.update(status: "prepartion")
    end
    redirect_to admin_order_path(@order_product.order_id)
  end

  private

  def order_product_params
    params.require(:order_product).permit(:production_status)
  end
end
