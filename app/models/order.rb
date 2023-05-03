class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy
  #支払方法のenum
  enum payment: { credit_card: 0, transfer: 1 }
  #注文ステータスのenum
  enum status: {waiting: 0, confirmation: 1, production: 2, prepartion: 3, sent: 4}


  def subtotal
    tax_price * product_quantity
  end

end

