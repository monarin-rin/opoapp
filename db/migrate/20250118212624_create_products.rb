class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :tax_rate, precision: 5, scale: 2, null: false, default: 10.0
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
