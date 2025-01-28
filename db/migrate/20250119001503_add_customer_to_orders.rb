class AddCustomerToOrders < ActiveRecord::Migration[6.0]
  def change
    # すでに 'customer_id' カラムがある場合は、マイグレーションをスキップするか、修正します。
    unless column_exists?(:orders, :customer_id)
      add_reference :orders, :customer, null: false, foreign_key: true
    end
  end
end
