class Invoice < ApplicationRecord
  belongs_to :order

  before_save :calculate_tax

  validates :invoice_number, :company_name, :company_address, :company_tax_id,
            :customer_name, :customer_address, :tax_rate, :total_amount, presence: true
  validates :tax_rate, :total_amount, numericality: { greater_than_or_equal_to: 0 }

  def calculate_tax
    self.tax_amount = total_amount * (tax_rate / 100)
  end
end
