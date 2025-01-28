class AddNameAndDescriptionToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :name, :string
    add_column :orders, :description, :text
  end
end
