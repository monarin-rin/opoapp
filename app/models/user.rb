class User < ApplicationRecord
  # Deviseのモジュール設定（必要な機能を有効に）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
end
