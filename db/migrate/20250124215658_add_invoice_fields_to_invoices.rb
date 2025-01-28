class AddInvoiceFieldsToInvoices < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :invoice_number, :string
    add_column :invoices, :company_name, :string
    add_column :invoices, :company_address, :string
    add_column :invoices, :company_tax_id, :string
    add_column :invoices, :customer_name, :string
    add_column :invoices, :customer_address, :string
    add_column :invoices, :tax_rate, :decimal
    add_column :invoices, :tax_amount, :decimal
    add_column :invoices, :total_amount, :decimal
  end
end
