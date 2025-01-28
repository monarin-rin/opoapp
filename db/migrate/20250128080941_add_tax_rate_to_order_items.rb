class AddTaxRateToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :order_items, :tax_rate, :decimal
  end
end
