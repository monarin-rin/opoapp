class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :order, null: false, foreign_key: true
      t.datetime :invoice_date
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
