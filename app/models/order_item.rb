class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # 商品ごとの税率を使って消費税額を計算するメソッドを追加
  def calculate_tax
    self.tax_amount = quantity * product.price * (product.tax_rate / 100.0)
  end
end
