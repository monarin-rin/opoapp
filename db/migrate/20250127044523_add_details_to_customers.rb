class AddDetailsToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :contact_person, :string
  end
end
