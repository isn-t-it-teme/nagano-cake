class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :item

  #制作ステータスのenum
  enum production_status: {cannot_start: 0, waiting_for_payment: 1, in_production: 2, completion_of_production: 3}

  def subtotal
    tax_price * product_quantity
  end
end
