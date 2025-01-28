class Invoice < ApplicationRecord
  belongs_to :order

  before_save :calculate_tax

  validates :invoice_number, :company_name, :company_address, :company_tax_id,
            :customer_name, :customer_address, :tax_rate, :total_amount, presence: true
  validates :tax_rate, :total_amount, numericality: { greater_than_or_equal_to: 0 }

  def calculate_tax
    # 商品ごとの税額を合計
    self.tax_amount = order.order_items.sum(&:tax_amount)

    # 合計金額を計算
    self.total_amount = order.order_items.sum { |item| item.quantity * item.product.price } + self.tax_amount
  end
end
