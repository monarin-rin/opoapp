class AddTaxRateToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :tax_rate, :decimal
  end
end
