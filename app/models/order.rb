class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_one :invoice, dependent: :destroy

  # 仮想属性を追加（データベースに保存されない属性）
  attr_accessor :create_invoice

  validates :name, presence: { message: "注文名が空欄です。内容を記入して次に進んでください。" }
  validates :description, presence: { message: "説明欄が空欄です。内容を記入して次に進んでください。" }
end
